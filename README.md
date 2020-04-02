# README

[TOC]

## Objeto

**Montar un entorno de entrega y compartición de actividades Profesores-Alumnos con GIT y un entorno CI/CD** (para automatizar la corrección de las prácticas de los alumnos).

Para esto se implementa un [esquema de compartición](wiki/Git-0-RecepcionActividadesGit.md) de actividades entre alumnos e instructor con GIT y una herramienta de integración continua como Jenkins, todo ello descrito en [la documentación](https://bitbucket.org/eduxunta/edu-devops-environment/wiki/Home).

## Pre-requisitos

* [Git](https://git-scm.com)

* [Docker](https://docs.docker.com/get-docker/). Se ha verificado el funcionamiento en [*MacOS*](https://www.docker.com/products/docker-desktop) y [*Linux Ubuntu/Debian*](https://docs.docker.com/install/linux/docker-ce/debian/)

## Ejecución del Jenkins

Existe un [`makefile`](Makefile) para facilizar el inicio de jenkins y las acciónes (targets) preestablecidas. Se ejecutan realizando `make <target>`, por ejemplo:

```bash
% make help  

-------------------------------------------------
Entorno CI/CD EDU 👩‍🏫 👨‍🏫 🖍 📝 
-------------------------------------------------

usage: make [target]

targets:

help                       Show this help message
jenkins-run                Start the deployments containers PRODUCTION JENKINS VERSION (Detached)
jenkins-stop               Stop PRODUCTION JENKINS VERSION
jenkins-build              Build DEMO JENKINS VERSION
jenkins-upgrade            Pull last image jenkins (need rebuild)
jenkins-sandbox-run        Start the deployments containers DEMO JENKINS VERSION (Detached)
jenkins-sandbox-stop       Stop DEMO JENKINS VERSION
jenkins-sandbox-build      Build DEMO JENKINS VERSION

```

## Scripts de Edu-Git

Incluir en el *PATH del sistema*, la carpeta `scripts/edu-scripts/`, para poder utilizarlos tal y como se refleja en [la documentación](https://bitbucket.org/eduxunta/edu-devops-environment/wiki/Home).

## Entorno estable

Representa un Jenkins *corriendo* con todos los plugins necesarios para llevar a cabo la validación de actividades propuestas hasta la fecha. **Es necesaria su configuración inicial** (creación de usuario, configuración de dominio, etc...)

Creará un volumen en la raiz del repo: `jenkins-home`

## Entorno sandbox

Representa un Jenkins *corriendo* con todos los plugins necesarios para llevar a cabo la validación de actividades propuestas hasta la fecha. **NO es necesaria su configuración inicial** ya que tiene por defecto una configuración funcional para hacer pruebas sobre él.

Creará un volumen en la raiz del repo: `jenkins-home-sandbox`

Credenciales:

	username: admin
	password: admin

> IMPORTANTE: Cada vez que se inicia, se ejecuta el siguiente [groovy script](jenkins/jenkinsMyImage-sandbox/security.groovy) dentro del container por lo que se restaura aunque se cambien el usuario y password. **NO UTILIZAR EN AMBIENTES DE PRODUCCIÓN**

## Contenidos adicionales

* En `scripts/edu-scripts/deprecated/` hay scripts que se llegaron a utilizar pero que ya no tiene sentido usarlos. Muestran el proceso tomado hasta llegar a la solución actual.

* En `scripts/others` hay scripts que no tienen que ver necesariamente con el propósito y objetivo de este repo pero que se han depositado como contenido de interés.


## Guía de contribución

* Corrección y mejora de scripts, documentación, etc.
* Propuesta y/o desarrollo de nuevos plugins para Jenkins
* Sugerencias a través de [Issues](https://bitbucket.org/eduxunta/edu-devops-environment/issues)
* Mejora de la documentación
* Compartir el modelo con otros docentes
* Generar nuevas propuesta de actividades para alumnos
* Acoplamiento de otras tecnologías al modelo.

## Contacto

`enrique.agrasar [arroba] edu.xunta.es`

## Licencia

El software de este repo es libre publicado bajo los términos de GNU Free Documentation License Version 1.3, puedes redistribuirlo y/o modificarlo. Lee el fichero [LICENSE](LICENSE) en este repositorio.

Este programa se distribuye con la esperanza de que sea útil, pero **SIN NINGUNA GARANTÍA**; sin siquiera la garantía implícita de comercialidad o aptitud para un propósito en particular. Ver el Licencia pública general de GNU para más detalles.

[La documentación](https://bitbucket.org/eduxunta/edu-devops-environment/wiki/Home) es publicada bajo los términos de GNU Free Documentation License Version 1.3, lee el fichero [LICENSE](https://bitbucket.org/eduxunta/edu-devops-environment/wiki/LICENSE) en la wiki.