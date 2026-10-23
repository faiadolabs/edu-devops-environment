# README

[TOC]

## Objeto

**Montar un entorno de entrega y compartición de actividades Profesores-Alumnos con GIT y un entorno CI/CD** (para automatizar la corrección de las prácticas de los alumnos).

Para esto se implementa un [esquema de compartición][esquema] de actividades entre alumnos e instructor con GIT y una herramienta de integración continua como Jenkins, todo ello descrito en [la documentación][wiki].
## Pre-requisitos

* [Git](https://git-scm.com)

* [Docker](https://docs.docker.com/get-docker/). Se ha verificado el funcionamiento en [*MacOS*](https://www.docker.com/products/docker-desktop) y [*Linux Ubuntu/Debian*](https://docs.docker.com/install/linux/docker-ce/debian/)

## Ejecución del Jenkins

> [!NOTE]
> Actualmente ya no estoy empleando tanto Jenkins. Empleo las automatizaciones de la propia forja (github o gitlab) a través de _pipelines_.

Existe un [`makefile`](Makefile) para facilizar el inicio de jenkins y las acciónes (targets) preestablecidas. Se ejecutan realizando `make <target>`, por ejemplo:

```bash
% make help  

-------------------------------------------------
Entorno CI/CD EDU 👩‍🏫 👨‍🏫 🖍 📝 
-------------------------------------------------

usage: make [target]

targets:

help                       Show this help message
jenkins-run                Start PRODUCTION JENKINS VERSION (Detached)
jenkins-stop               Stop PRODUCTION JENKINS VERSION
jenkins-enter              Execute bash inside container
jenkins-build              Build DEMO JENKINS VERSION
jenkins-upgrade            Pull last image jenkins (need rebuild)
jenkins-sandbox-run        Start DEMO JENKINS VERSION (Detached)
jenkins-sandbox-stop       Stop DEMO JENKINS VERSION
jenkins-sandbox-enter      Execute bash inside container
jenkins-sandbox-build      Build DEMO JENKINS VERSION

```

## Scripts de Edu-Git

> [!CAUTION]
> Ya no se mantienen ni se emplean estos scripts actualmente. Empaqueté estos scripts en un artefacto de npm llamado [`edu-xunta`][npm-edu-git]. Fundamentalmente se basan en los que aquí se describen, pero ya se mantienen en [un repo dedicado][repo-edu-git]

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
* Sugerencias y contribuciones gestionadas a través de [Issues][issues-doc]
* Mejora de la documentación
* Compartir el modelo con otros docentes
* Generar nuevas propuesta de actividades para alumnos
* Acoplamiento de otras tecnologías al modelo.

## Contacto

`enrique.agrasar [arroba] edu.xunta.es`

## Licencia

El software de este repo es libre publicado bajo los términos de GNU Free Documentation License Version 1.3, puedes redistribuirlo y/o modificarlo. Lee el fichero [LICENSE](LICENSE) en este repositorio.

Este programa se distribuye con la esperanza de que sea útil, pero **SIN NINGUNA GARANTÍA**; sin siquiera la garantía implícita de comercialidad o aptitud para un propósito en particular. Ver el Licencia pública general de GNU para más detalles.

[La documentación][wiki] es publicada bajo los términos de GNU Free Documentation License Version 1.3, lee el fichero [LICENSE][license-doc] en la wiki.

---

[wiki]: https://github.com/faiadolabs/edu-devops-environment/wiki
[esquema]: https://github.com/faiadolabs/edu-devops-environment/wiki/Git-0-RecepcionActividadesGit
[issues-doc]: https://github.com/faiadolabs/edu-devops-environment/issues
[license-doc]: https://github.com/faiadolabs/edu-devops-environment/blob/main/LICENSE
[npm-edu-git]: https://www.npmjs.com/package/edu-git
[repo-edu-git]: https://github.com/faiadolabs/edu-git
