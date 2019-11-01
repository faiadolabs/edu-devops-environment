
################################
# Official Jenkins Docker image (https://github.com/jenkinsci/docker/blob/master/README.md#official-jenkins-docker-image)
################################

FROM jenkins/jenkins:lts-alpine

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
