
.PHONY: all
all: install

.PHONY: install
install:
	apt update
	apt install vim -y

	apt-get install software-properties-common
	apt-get install git-lfs
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
	apt-get install git-lfs

	git lfs install


	touch ~/.profile
	curl -s https://get.modular.com | sh -
	modular auth
	modular install mojo

	MOJO_PATH=$(modular config mojo.path) \
  	&& echo 'export MODULAR_HOME="'$HOME'/.modular"' >> ~/.profile \
  	&& echo 'export PATH="'$MOJO_PATH'/bin:$PATH"' >> ~/.profile \
  	&& source ~/.profile
	
	modular install max
	MAX_PATH=$(modular config max.path) \
  	&& python3 -m pip install --find-links $MAX_PATH/wheels max-engine

  	MAX_PATH=$(modular config max.path) \
  	&& echo 'export MODULAR_HOME="'$HOME'/.modular"' >> ~/.profile \
  	&& echo 'export PATH="'$MAX_PATH'/bin:$PATH"' >> ~/.profile \
  	&& source ~/.profile

	