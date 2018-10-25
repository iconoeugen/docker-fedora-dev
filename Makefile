NAME = iconoeugen/fedora-dev
all: build

build:
	docker build -t $(NAME) -t $(NAME):27 .

build-nocache:
	docker build -t $(NAME) -t $(NAME):27 . --no-cache

run:
	docker run -it $(NAME)
