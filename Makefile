CONTAINER_NAME=example-python
DOCKER_REGISTRY_URL=de.icr.io/knowledge-example
CONTAINER_VERSION:=$(shell git describe --always --tags)

help:                      ## Show this help.
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | tr -d '##' | tr -d '$$'

init-semver:               ## Tag de current commit to a valid semantic version (0.0.0)
	git tag 0.0.0 -m "first semver tag"

release-patch:             ## Tag the release as a patch release and push tag to git.
	./semver release-patch
	$(MAKE) docker-build
	$(MAKE) docker-publish

release-minor:             ## Tag the release as a minor  releaseand push tag to git.
	./semver release-minor
	$(MAKE) docker-build
	$(MAKE) docker-publish

release-major:             ## Tag the release as a major release and push tag to git.
	./semver release-major
	$(MAKE) docker-build
	$(MAKE) docker-publish

docker-build:              ## Build the docker container.
	docker build -t $(CONTAINER_NAME):$(CONTAINER_VERSION) .

docker-publish:            ## Publish the docker image to registry using existing version.
	docker tag $(CONTAINER_NAME):$(CONTAINER_VERSION) $(DOCKER_REGISTRY_URL)/$(CONTAINER_NAME):$(CONTAINER_VERSION)
	docker push $(DOCKER_REGISTRY_URL)/$(CONTAINER_NAME):$(CONTAINER_VERSION)
