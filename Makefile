NAME = iconoeugen/fedora-dev
all: build

build:
	docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t $(NAME) -t $(NAME):27 .

build-nocache:
	docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t $(NAME) -t $(NAME):27 . --no-cache

run:
	docker run -it $(NAME)
