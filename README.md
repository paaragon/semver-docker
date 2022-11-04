# semver-docker

The Makefile of this repo helps to build and deploy an application.

The language of the application to deploy is indiferent, you just need to describe your Dockerfile.

## Make commands

* help: Show this help.
* init-semver: Tag de current commit to a valid semantic version (0.0.0)
* release-patch: Tag the release as a patch release and push tag to git.
* release-minor: Tag the release as a minor  releaseand push tag to git.
* release-major: Tag the release as a major release and push tag to git.
* docker-build: Build the docker container.
* docker-publish: Publish the docker image to registry using existing version.

## Test the example application

The application provided in this repo is a Python flask app

```python
# install dependencies
pip3 install -r requirements.txt

# run the app
python3 -m flask run
```

## Version, build and publish application

```
make release-patch
make release-minor
make release-major
```


