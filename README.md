# README LegalGratification Test Buk

---

## Tabla de Contenidos

- [Prerequisitos](#prerequisitos) 
- [Descripción](#descripción)  
- [Requerimientos](#requerimientos)  
- [Diseño y Arquitectura](#diseño-y-arquitectura)  
- [Prerrequisitos](#prerrequisitos)  
- [Instalación](#instalación)  
- [Configuración](#configuración)  
- [Uso local](#uso-local)  
- [Ejecución con Docker](#ejecución-con-docker)  
- [Contribuir](#contribuir)  
- [Licencia](#licencia)

---

## Prerequisitos

[![Ruby](https://img.shields.io/badge/Ruby-3.4.4-red)](https://www.ruby-lang.org/)  
[![Rails](https://img.shields.io/badge/Rails-8.0.2-blue)](https://rubyonrails.org/)  
[![Docker](https://img.shields.io/badge/Docker-28.0.1-blue)](https://www.docker.com/)  
[![Node.js](https://img.shields.io/badge/Node–20.8.0-green)](https://nodejs.org/)

## Descripción

`LegalGratification` es una aplicación Rails que genera **formularios dinámicos** y **cálculos de gratificaciones** adaptados al país seleccionado. Emplea los principios SOLID, el patrón **Strategy** para desacoplar vistas y cálculos y utiliza el método **Simple Factory** basado en reflexión para instanciar la estrategia correcta según un archivo JSON de configuración.

---


## Requerimientos:

1. Crear un formulario dinamico, que cambie según del país escogido.
2. Crear un método de cáclculo dinámico, cuyo resultado y cálculo cambie dinamicamente según el país escogido.

---

## Diseño y Arquitectura

- Se aplican en forma general los principios **SOLID** y **inyección de dependencias**. 
- Se utiliza el patrón **Strategy** cambiar vistas (`View`) y lógica de gratificación (`GeneralGratification`) en tiempo de ejecución.  
- Se aplica un **Simple Factory** (`GratificationCountryFactory`) con reflexión para leer `config/factories.json` y crear instancias de forma dinámica.

El Modelo UML de las clases principales se muestra en el siguiente diagrama mermaid embebido:

---

## Instalación

1. **Clonar el repositorio**  
```bash
    git clone https://github.com/tu-org/LegalGratification.git
   cd LegalGratification
```
2. **Instalar dependencias Ruby**   
```bash
    bundle install
```

3. Instalar dependencias de JavaScript
```bash
    yarn install    # o npm ci
```
- Se utiliza el comando "rails new LegalGratification" para inciar la aplicación ruby on rails, con todos los archivos que este comando trae por defecto.


## Configuración

1. Ejecutar el comando 
```bash
rails secret
```
y copiar la clave generada.

2. Crear una variable de entorno de nombre ``SECRET_KEY_BASE`` en el archivo .env y copiar el valor de la clave generada en el paso anterior (SECRET_KEY_BASE=tu_secret_key_generada_con_rails_secret).

3. Ejecutar comandos de base de datos (en esta implementación no se utiliza, pero igual es necesario configurarla).

```bash
rails db:create
rails db:migrate
```

## Configuración Específica de la Aplicación


1. Se deben tener creadas las vistas (activas) que se van a usar en cada país, estas vistas están presentes en el directorio ${root}/app/views/surveys. De forma inicial se tienen creadas vistas para Chile, Colombia y México.

2. Se deben tener creadas las implementaciones (activas) de las gratificaciones en el directorio ${root}/app/classes/gratification_implementations. De forma inicial se tienen creadas implementaciones de gratificaciones para Chile, Colombia y México. Estas están asociadas a vistas específicas.

3. Para configurar este programa se debe tener creado el archvo ``factories.json`` de configuración en la ruta ${root}/config/factories.json. Este debe tener la siguiente estructura:

```json
{
    "chile": {
        "currency": "CLP",
        "name": "Chile",
        "code": "chile",
        "factories": [
            {
                "name": "chile_gratification_v_1",
                "injects": {
                    "implementation_class": "ChileGratification",
                    "implementation_inputs": {},
                    "view_class": "ViewChile",
                    "view_inputs": {}
                },
                "version": 1,
                "isActive": true
            }
        ]
    },
    "colombia": {
        "currency": "COP",
        "name": "Colombia",
        "code": "colombia",
        "factories": [
            {
                "name": "colombia_gratification_v_1",
                "injects": {
                    "implementation_class": "ColombiaGratification",
                    "implementation_inputs": {},
                    "view_class": "ViewColombia",
                    "view_inputs": {}
                },
                "version": 1,
                "isActive": true
            }
        ]
    },
    "mexico": {
        "currency": "MXN",
        "name": "México",
        "code": "mexico",
        "factories": [
            {
                "name": "mexico_gratification_v_1",
                "injects": {
                    "implementation_class": "MexicoGratification",
                    "implementation_inputs": {},
                    "view_class": "ViewMexico",
                    "view_inputs": {}
                },
                "version": 1,
                "isActive": true
            }
        ]
    }
}
```

4. En el archivo ${root}/config/factories.json deben estar presentes las configuraciones de las gratificaciones de cada país.
    - En este archivo la llave raíz representa al código estándar que va a tener un país.
    - En los objetos de cada pais se van a tener los elementos
        - currency: código de la moneda.
        - name: nombre visible del país.
        - code: código del país.
        - factories: corresponde a un arreglo de todas las posibles configuraciones de implementación para cada país. Únicamente una configuración puede estar activa en un momento determinado. Los campos que pueden tener son los siguientes:
            - name: nombre de la configuración de implementación.
            - version: version de la configuración.
            - isActive: indica si está activa o no la configuración.
            - injects: Contiene las clases y las entradas de las dependencias de implementación. Los campos que contiene injects son:
                - implementation_class: nombre de la clase que implementa las funciones de gratificación.
                - implementation_inputs: contiene las entradas que se le agregan a la clase que implementa las funciones de gratificación, cuando esta se instancia (como diccionario).
                - view_class: nombre de la clase que maneja la interacción con la vista del país.
                - view_inputs: contiene las entradas que se le agregan a la clase que maneja la interacción con la vista del país, cuando esta se instancia (como diccionario).

## Uso local

### Mediante Comando Rails

1. Para ejecutar en forma local este archivo se puede realizar lo siguiente:

```bash
rails server
```

2. Posteriormente para acceder a la aplicación mediante se debe ingresar al enlace ``http://localhost:3000``.

3. Para finalizar la ejecución del programa se debe ingresar CTRL+C en la terminal en la cual se ejecuto el proceso.

### Mediante Dockers 

1. Se debe crear la imagen (en base al archivo Dockerfile).

```bash
docker build -t legal-gratification .
```

2. Posteriormente se debe ejecutar un contenedor en base a la imagen creada anteriormente.

```bash
docker run -p 3000:80 \
  -e SECRET_KEY_BASE=<tu_secret_key> \
  legal-gratification
```

3. Finalmente para acceder a la aplicación se debe acceder al enlace ``http://localhost:3000``




