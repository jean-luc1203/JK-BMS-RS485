#!/usr/bin/with-contenv bashio

# Récupération des options de configuration
CONFIG_PATH=/data/options.json
DEVICE=$(bashio::config 'device')
BAUD_RATE=$(bashio::config 'baud_rate')
DATA_BITS=$(bashio::config 'data_bits')
PARITY=$(bashio::config 'parity')
STOP_BITS=$(bashio::config 'stop_bits')

# Configuration du port série pour Modbus
export MODBUS_SERIAL_PORT=$DEVICE
export MODBUS_SERIAL_BAUD=$BAUD_RATE
export MODBUS_SERIAL_DATA_BITS=$DATA_BITS
export MODBUS_SERIAL_PARITY=$PARITY
export MODBUS_SERIAL_STOP_BITS=$STOP_BITS

# Création du répertoire de données s'il n'existe pas
mkdir -p /data/node-red

# Copie du flow préconfiguré s'il n'existe pas déjà
if [ ! -f "/data/node-red/flows.json" ]; then
    cp /config/node-red/flows.json /data/node-red/flows.json
fi

# Démarrage de Node-RED
bashio::log.info "Démarrage de Node-RED avec configuration BMS Modbus RS485..."
node-red --userDir /data/node-red
