#!/bin/bash




# exit script on any error
set -ex
echo "setting up initial configurations"

NODE_BINARY=akash
AKASH_NET_BASE=https://raw.githubusercontent.com/ovrclk/net/master
AKASH_NET="$AKASH_NET_BASE/$NETWORK"
if [ ! -f "$NODE_HOME/config/config.toml" ];
then

  ${NODE_BINARY} init ${AKASH_MONIKER:-nonamenode} --home=${NODE_HOME:-/.akash} --chain-id=${CHAIN_ID:akashnet-2}

  cd $NODE_HOME/config

  echo "removing autogenerated genesis and config files"
  rm genesis.json


  echo "downloading genesis.json"

  wget "$AKASH_NET/genesis.json"
#  cp genesis.json $NODE_HOME/config/genesis.json

  echo "validating genesis"
  ${NODE_BINARY} --home=${NODE_HOME:-/.akash} validate-genesis

  echo "downloading seed-nodes.txt"

  wget "$AKASH_NET/seed-nodes.txt"

  echo "downloading peer-nodes.txt"

  wget "$AKASH_NET/peer-nodes.txt"

fi

echo "init complete  ---- starting..."

bash -c "akash start --home=${NODE_HOME:-/.akash}";
