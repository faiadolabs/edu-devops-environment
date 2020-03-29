
################################
# Official Jenkins Docker image (https://github.com/jenkinsci/docker/blob/master/README.md#official-jenkins-docker-image)
################################

FROM jenkins/jenkins:lts-alpine

USER root
RUN apk add --update maven

####################### INSTALAR DOCKER #########################################
# https://wiki.alpinelinux.org/wiki/Docker
# https://stackoverflow.com/questions/39460085/docker-alpine-images-basic-commands-are-not-working

# Se crea específicamente el grupo antes de la instalación para que coincida con gid en el host (actualmente 998)
RUN addgroup --gid 998 docker

RUN apk add docker

# Permitir al user jenkins utilizar docker
RUN addgroup jenkins docker && addgroup jenkins root
################################################################################

COPY gitconfig /etc/gitconfig
USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Script para iniciar un admin por defecto y evitar el setup
# COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

# Generado keystore con entrada de certificado autofirmado (https://stackoverflow.com/questions/40126736/enable-https-in-jenkins)
# keytool -genkey -keyalg RSA -alias "jenkins-SanClemente" -keystore "miKeyStore.jks" -validity 365 -keysize 2048 -dname "CN=iesjenkins.faiadolabs.com, OU=DeptInformatica, O=IES-SanClemente, L=Santiago de Compostela, ST=A Coruña, C=ES" -ext SAN=dns:iesjenkins.faiadolabs.com -storepass sanClemente1920

# Exportación en forma de fichero p12
# keytool -importkeystore -srckeystore "miKeyStore.jks" -storepass sanClemente1920 -destkeystore "jenkins.p12" -srcstoretype JKS -deststoretype PKCS12 -deststorepass sanClemente1920

COPY jenkins.p12 /var/lib/jenkins/jenkins.p12
ENV JENKINS_OPTS --httpPort=8080 --httpsPort=8443 --httpsKeyStore="/var/lib/jenkins/jenkins.p12" --httpsKeyStorePassword=sanClemente1920
EXPOSE 8443

# Configurando plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
