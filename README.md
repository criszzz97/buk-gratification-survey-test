# README

* Requerimientos:
1. Crear un formulario dinamico, que cambie según del país escogido.
2. Crear un método de cáclculo dinámico, cuyo resultado y cálculo cambie dinamicamente según el país escogido.


* Diseño:

* Se buscó crear un diseño tal que  permitiera mantener los principios SOLID.

* Se buscará utilizar la injección de dependencias, para injectar implementaciones de vistas y calculos de gratificaciones a cada instancia de país.

* Al analizar los requerimientos se decide utilizar el patron de diseño strategy para poder cambiar en tiempo de ejecución distintas variantes de vistas y calculos de gratificaciones.

* Se utilizó un simple factory para instanciar en tiempo de ejecución cada país con su implementación particular, además para este factory se utilizara reflexión para poder leer desde un archivo de configuración que clase se debe instanciar.

* Ruby version

* System dependencies

* Configuration

Este programa utiliza 

Para configurar este programa se debe tener lo siguiente:

- Se deben tener creadas las vistas (activas) que se van a usar en cada país, estas vistas están presentes en el directorio ${root}/app/views/surveys. De forma inicial se tienen creadas vistas para Chile, Colombia y México.

- Se deben tener creadas las implementaciones (activas) de las gratificaciones en el directorio ${root}/app/classes/gratification_implementations. De forma inicial se tienen creadas implementaciones de gratificaciones para Chile, Colombia y México. Estas están asociadas a vistas específicas.

- En el archivo ${root}/config/factories.json deben estar presentes las configuraciones de las gratificaciones de cada país.
    - En este archivo la llave raíz representa al código estandar que va a tener un país.
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

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

Para ejecutar en forma local este archivo se puede utilizar rails s

* ...
