CONTAINER_NAME=assiss-ms-orch
DOCKER_REGISTRY_URL=de.icr.io/assisseed
CONTAINER_VERSION:=$(shell git describe --always --tags)

help:                      ## Show this help.
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | tr -d '##' | tr -d '$$'

release-patch:             ## Tag the release as a patch release and push tag to git.
	./semver $(VERSION_FILE) release-patch
	$(MAKE) docker-build
	$(MAKE) docker-publish

release-minor:             ## Tag the release as a minor  releaseand push tag to git.
	./semver $(VERSION_FILE) release-minor
	$(MAKE) docker-build
	$(MAKE) docker-publish

release-major:             ## Tag the release as a major release and push tag to git.
	./semver $(VERSION_FILE) release-major
	$(MAKE) docker-build
	$(MAKE) docker-publish

maven-package:
	mvn -f ./pom.xml clean package

docker-build:              ## Build the docker container.
	$(MAKE) maven-package
	docker build -t $(CONTAINER_NAME):$(CONTAINER_VERSION) .

docker-publish:            ## Publish the docker image to registry using existing version.
	docker tag $(CONTAINER_NAME):$(CONTAINER_VERSION) $(DOCKER_REGISTRY_URL)/$(CONTAINER_NAME):$(CONTAINER_VERSION)
	docker push $(DOCKER_REGISTRY_URL)/$(CONTAINER_NAME):$(CONTAINER_VERSION)
