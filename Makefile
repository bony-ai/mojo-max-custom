.PHONY: all setup mojo install run

all: setup install mojo run

setup:
	apt-get update
	apt-get install -y vim software-properties-common git-lfs
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
	apt-get install -y git-lfs

mojo:
	touch ~/.profile
	curl -s https://get.modular.com -o modular_install.sh
	# Inspect before executing
	# bash modular_install.sh
	modular auth
	modular install max
	$(eval MAX_PATH := $(shell modular config max.path))
	python3 -m pip install --find-links $(MAX_PATH)/wheels max-engine
	echo 'export MODULAR_HOME="$$HOME/.modular"' >> ~/.profile
	echo 'export PATH="$(MAX_PATH)/bin:$$PATH"' >> ~/.profile

install:
	git clone https://huggingface.co/casperhansen/mixtral-instruct-awq && \
	cd mixtral-instruct-awq && \
	git lfs install && \
	cd ..

run:
	. ~/.profile && \
	mojo main.🔥
