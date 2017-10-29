IMAGE=acsone/odoo-ci
TAG=latest

all: build

.PHONY: build
build:
	docker build -t $(IMAGE):$(TAG) .

.PHONY: push
push: build
	docker push $(IMAGE):$(TAG)

.PHONY: bash
bash: build
	docker run --rm -it \
	  -v ~/.config/git-autoshare:/home/odoo/.config/git-autoshare \
	  -v ~/.cache/git-autoshare:/home/odoo/.cache/git-autoshare \
	  -v ~/.cache/pip:/home/odoo/.cache/pip \
	  -e LOCAL_USER_ID=`id -u` \
	  $(IMAGE) bash
