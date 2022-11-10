CONTAINER_NAME=example-python
DOCKER_REGISTRY_URL=de.icr.io/knowledge-example
VERSION:=$(shell ./semver get-git-version)

help:                      ## Show this help.
	@grep -h "##" $(MAKEFILE_LIST) | grep -v grep | tr -d '##' | tr -d '$$'

init-semver:               ## Tag de current commit with a valid semantic version (0.0.0).
	git tag 0.0.0 -m "first semver tag"

version:                   ## Check the current project version.
	./semver get-git-version

patch:                     ## Tag changes increasing the patch position.
	./semver check-clean
	./semver patch

minor:                     ## Tag changes increasing the minor position.
	./semver check-clean
	./semver minor

major:                     ## Tag changes increasing the major position.
	./semver check-clean
	./semver major

publish-patch:             ## Tag changes increasing the patch position and publish the project.
	$(MAKE) patch
	$(MAKE) publish

publish-minor:             ## Tag changes increasing the minor position and publish the project.
	$(MAKE) minor
	$(MAKE) publish

publish-major:             ## Tag changes increasing the major position and publish the project.
	$(MAKE) major
	$(MAKE) publish

publish:                   ## Build the docker image and publish it.
	./semver check-clean
	$(MAKE) docker-build
	$(MAKE) docker-publish

docker-build:              ## Build the docker image.
	docker build -t $(CONTAINER_NAME):$(VERSION) .

docker-publish:            ## Publish the docker image to registry.
	docker tag $(CONTAINER_NAME):$(VERSION) $(DOCKER_REGISTRY_URL)/$(CONTAINER_NAME):$(VERSION)
	docker push $(DOCKER_REGISTRY_URL)/$(CONTAINER_NAME):$(VERSION)
