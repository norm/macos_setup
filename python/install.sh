export ASDF_DIR=~/var/asdf
export ASDF_DATA_DIR=$ASDF_DIR
source $ASDF_DIR/asdf.sh

asdf plugin add python || true

asdf install python 3.9.10 || true
asdf install python 3.10.2 || true

asdf global python 3.9.10 || true

pip install --upgrade pip
pip install --upgrade -r requirements.txt

asdf reshim
