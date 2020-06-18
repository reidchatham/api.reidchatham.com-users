# image
USERNAME=rchatham
IMAGE_NAME=api.reidchatham.com-users
VERSION=1.0.0
CONTAINER_NAME=api.reidchatham.com-users
# CONTAINER_PORT=80
# EXPOSED_PORT=80

docker_build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

docker_tag:
	docker tag $(IMAGE_NAME):$(VERSION) $(USERNAME)/$(IMAGE_NAME):$(VERSION)

docker_push:
	docker push $(USERNAME)/$(IMAGE_NAME):$(VERSION)
