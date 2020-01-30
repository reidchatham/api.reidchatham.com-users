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

# docker-machine
DIGITALOCEAN_TOKEN_FILE=digital-ocean.token
DIGITALOCEAN_TOKEN=`cat $(DIGITALOCEAN_TOKEN_FILE)`
DIGITALOCEAN_DROPLET_NAME=api.reidchatham.com-sandbox

docker_machine_do_launch:
	docker-machine create --driver=digitalocean --digitalocean-access-token $(DIGITALOCEAN_TOKEN) $(DIGITALOCEAN_DROPLET_NAME)
	docker-machine env $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_do_launch_2:
	docker-machine create --driver=digitalocean --digitalocean-access-token $(DIGITALOCEAN_TOKEN) $(DIGITALOCEAN_DROPLET_NAME)-2
	docker-machine env $(DIGITALOCEAN_DROPLET_NAME)-2

docker_machine_do_launch_3:
	docker-machine create --driver=digitalocean --digitalocean-access-token $(DIGITALOCEAN_TOKEN) $(DIGITALOCEAN_DROPLET_NAME)-3
	docker-machine env $(DIGITALOCEAN_DROPLET_NAME)-3

# attach shell to docker machine
docker_machine_do_eval:
	eval $(docker-machine env api.reidchatham.com-sandbox)

docker_machine_do_eval_2:
	eval $(docker-machine env api.reidchatham.com-sandbox-2)

docker_machine_do_eval_3:
	eval $(docker-machine env api.reidchatham.com-sandbox-3)


docker_machine_ls:
	docker-machine ls

docker_machine_do_ip:
	docker-machine ip $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_ssh:
	docker-machine ssh $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_stop:
	docker-machine stop $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_rm:
	docker-machine rm $(DIGITALOCEAN_DROPLET_NAME)

docker_machine_unset:
	docker-machine env -u
	eval $(docker-machine env -u)

#swarm
SWARM_NAME=api-reidchatham-com

docker_stack_deploy:
	docker stack deploy -c docker-compose.yml $(SWARM_NAME)

docker_stack_ps:
	docker stack ps $(SWARM_NAME)

docker_stack_rm:
	docker stack rm $(SWARM_NAME)

docker_swarm_init:
	docker swarm init

docker_swarm_leave:
	docker swarm leave --force
