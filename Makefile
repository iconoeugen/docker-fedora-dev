NAME = iconoeugen/fedora-dev
all: build

build:
	docker build -t $(NAME) -t $(NAME):28 .

build-nocache:
	docker build -t $(NAME) -t $(NAME):28 . --no-cache

run:
	docker run -it $(NAME)
