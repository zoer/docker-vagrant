NAME = zoer/vagrant
VERSION = 0.0.1

.PHONY: wheezy rbenv

all: build

build: wheezy rbenv

wheezy:
	docker build -t ${NAME}:wheezy debian/wheezy

rbenv:
	docker build -t ${NAME}:rbenv rbenv
