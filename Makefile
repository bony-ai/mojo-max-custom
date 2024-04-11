.PHONY: all setup mojo install run

all: setup-env mojo install run

setup-env:
	apt-get update
	apt-get install -y vim software-properties-common git-lfs
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

mojo:
	touch ~/.profile
	curl -s https://get.modular.com | sh -
	modular auth
	modular install max

	MAX_PATH=$(shell modular config max.path) && python3 -m pip install --find-links $(MAX_PATH)/wheels max-engine

	MAX_PATH=$(shell modular config max.path) \
	&& BASHRC=$( [ -f "$(HOME)/.bash_profile" ] && echo "$(HOME)/.bash_profile" || echo "$(HOME)/.bashrc" ) \
	&& echo 'export MODULAR_HOME="'$(HOME)'/.modular"' >> "$(BASHRC)" \
	&& echo 'export PATH="'$(MAX_PATH)'/bin:$(PATH)"' >> "$(BASHRC)" \
	&& source "$(BASHRC)"

install:
	git clone https://huggingface.co/casperhansen/mixtral-instruct-awq
	cd mixtral-instruct-awq
	git lfs install
	cd ..

	pip3 install transformers max



run:
	. "$(BASHRC)" && \
	. ~/.profile && \
	mojo main.🔥
