FROM mcr.microsoft.com/devcontainers/javascript-node:0-18

USER root
# Opción recomendada: omitimos la creación forzada
# RUN groupadd --gid 1000 node && \
#     useradd --uid 1000 --gid node --shell /bin/bash --create-home node

# Opción segura: creación condicional de grupo y usuario
RUN getent group node \  
    || groupadd --gid 1000 node \
 && id -u node > /dev/null 2>&1 \
    || useradd --uid 1000 --gid node --shell /bin/bash --create-home node

USER node
WORKDIR /workspaces
COPY --chown=node:node . /workspaces
RUN npm install

EXPOSE 3000
