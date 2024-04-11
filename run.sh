git clone https://github.com/bony-ai/mojo-max-custom
cd mojo-max-custom


git clone https://huggingface.co/casperhansen/mixtral-instruct-awq
cd mixtral-instruct-awq
git lfs install
cd ..


apt-get update
apt-get install -y vim software-properties-common git-lfs curl
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

curl -s https://get.modular.com | sh -
modular auth
modular install max

MAX_PATH=$(modular config max.path) \
  && python3 -m pip install --find-links $MAX_PATH/wheels max-engine

MAX_PATH=$(modular config max.path) \
  && BASHRC=$( [ -f "$HOME/.bash_profile" ] && echo "$HOME/.bash_profile" || echo "$HOME/.bashrc" ) \
  && echo 'export MODULAR_HOME="'$HOME'/.modular"' >> "$BASHRC" \
  && echo 'export PATH="'$MAX_PATH'/bin:$PATH"' >> "$BASHRC" \
  && source "$BASHRC"

python3 -m venv fire
source fire/bin/activate

python3 -m pip install -r requirements.txt

mojo main.🔥