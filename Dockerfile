ARG BUILD_FROM
FROM $BUILD_FROM

# Installation des dépendances nécessaires
RUN \
    apk add --no-cache \
    nodejs \
    npm \
    eudev \
    tini

# Installation de Node-RED et des packages Modbus
RUN npm install -g --unsafe-perm node-red \
    && npm install -g @flowfuse/node-red-dashboard && npm install -g node-red-contrib-buffer-parser

# Copier votre flow Node-RED préconfiguré
COPY flows.json /config/node-red/flows.json

# Copier le script de démarrage
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
