# Makefile for Dockerized Node.js app

IMAGE_NAME=cicd-demo
CONTAINER_NAME=cicd-demo
PORT=3000

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -d -p $(PORT):3000 --name $(CONTAINER_NAME) $(IMAGE_NAME):latest

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

logs:
	docker logs -f $(CONTAINER_NAME)

clean:
	docker rmi $(IMAGE_NAME):latest || true
	docker system prune -f

restart: stop run

.PHONY: build run stop logs clean restart
