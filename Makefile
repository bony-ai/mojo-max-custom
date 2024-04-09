.PHONY: all setup mojo install run

all: setup install mojo run

setup:
	apt update
	apt install vim -y
	apt-get install software-properties-common
	apt-get install git-lfs
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
	apt-get install git-lfs

mojo:
	touch ~/.profile
	curl -s https://get.modular.com | sh -
	modular auth
	modular install max

	MAX_PATH=$(modular config max.path) \
  	&& python3 -m pip install --find-links $MAX_PATH/wheels max-engine

	MAX_PATH=$(modular config max.path) && \
	echo 'export MODULAR_HOME="$$HOME/.modular"' >> ~/.profile && \
	echo 'export PATH="$$MAX_PATH/bin:$$PATH"' >> ~/.profile && \
	. ~/.profile

install:
	git clone https://huggingface.co/casperhansen/mixtral-instruct-awq
	cd mixtral-instruct-awq
	git lfs install
	cd ..

run:
	mojo main.🔥