#!/bin/bash

# Ubuntu
#---------
#******************************
#* INSTALACIÓN DOCKER         *
#******************************

# Actualiza los repos
sudo apt-get update
# Instala utilidades
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
# Agregar el gpg 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Agregar el repo
 sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Actualizar de nuevo
 sudo apt-get update
# Instalar docker
 sudo apt-get install docker-ce
# Iniciarlo con el sistema
sudo systemctl enable docker
# Agregar usuario al grupo docker 
sudo usermod -aG docker 
# Iniciar de nuevo con el usuario y probar 
docker run hello-world
******************************
* INSTALACIÓN DOCKER-COMPOSE *
******************************
# Obtener la versión actual más estable de docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Aplicar permiso de ejecución al binario
sudo chmod +x /usr/local/bin/docker-compose