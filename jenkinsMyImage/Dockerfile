
################################
# Official Jenkins Docker image (https://github.com/jenkinsci/docker/blob/master/README.md#official-jenkins-docker-image)
################################

FROM jenkins/jenkins:lts-alpine

ARG	timezone=Europe/Madrid
ENV	TZ $timezone

USER root

# Change timezone
#RUN	echo $timezone > /etc/timezone \
#	&& cp /usr/share/zoneinfo/$timezone /etc/localtime

RUN apk add --update maven

# https://wiki.alpinelinux.org/wiki/Docker
# https://stackoverflow.com/questions/39460085/docker-alpine-images-basic-commands-are-not-working
RUN apk add docker

# Permitir al user jenkins utilizar docker
RUN addgroup jenkins docker && addgroup jenkins root

# Install docker composer
# RUN apk add py-pip && apk add python-dev libffi-dev openssl-dev gcc libc-dev make

# RUN pip install docker-compose

USER jenkins
RUN git config --global user.email "jenkins@jenkins" && git config --global user.name "Jenkins"

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

# Generado keystore con entrada de certificado autofirmado (https://stackoverflow.com/questions/40126736/enable-https-in-jenkins)
# keytool -genkey -keyalg RSA -alias "localhost" -keystore "jenkins.jks" -validity 365 -keysize 2048 -dname "CN=localhost, OU=OU_name, O=OU_name, L=city, ST=State_name, C=two_letter_country_code" -ext SAN=dns:localhost,ip:127.0.0.1 -storepass holamundo

# Exportación en forma de fichero p12
# keytool -importkeystore -srckeystore "jenkins.jks" -storepass holamundo -destkeystore "jenkins.p12" -srcstoretype JKS -deststoretype PKCS12 -deststorepass holamundo

COPY jenkins.p12 /var/lib/jenkins/jenkins.p12
ENV JENKINS_OPTS --httpPort=8080 --httpsPort=8443 --httpsKeyStore="/var/lib/jenkins/jenkins.p12" --httpsKeyStorePassword=holamundo
EXPOSE 8443

# Configurando plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
