NAME = iconoeugen/fedora-dev
TAG=30
all: build

build:
	docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t $(NAME) -t $(NAME):$(TAG) .

build-nocache:
	docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t $(NAME) -t $(NAME):$(TAG) . --no-cache

run:
	docker run -it $(NAME):$(TAG)
