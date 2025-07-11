# README

* Requerimientos:

1. Crear un formulario dinamico, que cambie según del país escogido.
2. Crear un método de cáclculo dinámico, cuyo resultado y cálculo cambie dinamicamente según el país escogido.


* Diseño:

* Se buscó crear un diseño tal que  permitiera mantener los principios SOLID.

* Se buscará utilizar la injección de dependencias, para injectar implementaciones de vistas y calculos de gratificaciones a cada instancia de país.

* Al analizar los requerimientos se decide utilizar el patron de diseño strategy para poder cambiar en tiempo de ejecución distintas variantes de vistas y calculos de gratificaciones.

* Se utilizó un simple factory para instanciar en tiempo de ejecución cada país con su implementación particular, además para este factory se utilizara reflexión para poder leer desde un archivo de configuración que clase se debe instanciar.

* Setup Inicial
    - Se utiliza ruby 3.4.4 x86_64-linux
    - Se utiliza rails 8.0.2
    - Se utiliza el editor de texto VScode 1.101.2
    - Se utiliza Docker 28.0.1
    - Se utiliza Node v20.8.0

- Se utiliza el comando "rails new LegalGratification" para inciar la aplicación ruby on rails, con todos los archivos que este comando trae por defecto.


* Configuración

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

* Para ejecutar en forma local este archivo se puede realizar lo siguiente:

- Se debe ingresar en el directorio rais del programa (legal-gratification) y se debe ejecutar el comando rails s.

- Este programa al tener un Docker file asociado, significa que se puede crear una imagen Docker y se puede ejecutar un contenedor en base a esto. utilizar dockers para ejecutar este programa. Además al estar en docker su portabilidad es simple y se puede deployear como contenedor docker  mediante los siguientes comandos docker:


docker run -p 3001:80 -e SECRET_KEY_BASE={{secret_key}}sha256:e43f3d847cc3fd6c0299eb99bba3aed0ee44cd03050073bbf3b3e3cc26ed95f3

```mermaid
classDiagram
direction TB
    class View {
	    + getView() : String
    }

    class CountryGratification {
	    - code: String
	    - name: String
	    - viewHandler: View
	    - gratificationImplementation: GeneralGratification
	    - currency: String
	    + initialize(currency : String, name : String, code: String, gratificationImplementation : GeneralGratification, viewHandler : View)
	    + getName() : String
	    + getView() : String
	    + getDetails(input : any) : String
	    + getCurrency() : String
	    + getAmount(input : any) : Number
    }

    class GratificationCountryFactory {
	    - implViewModuleName : Module
	    - implModuleName : Module
	    - factoriesCode : String
	    - allCfg : Object
	    - rawCfg : String
	    + initialize()
	    + build(countryCode : String) : CountryGratification
    }

    class ViewMexico {
	    - baseViewFilePath : String
	    + initialize(baseViewFilePath : String)
	    + getView() : String
    }

    class ViewChile {
	    - baseViewFilePath : String
	    + initialize(baseViewFilePath : String)
	    + getView() : String
    }

    class ViewColombia {
	    - baseViewFilePath : String
	    + initialize(baseViewFilePath : String)
	    + getView() : String
    }

    class GeneralGratification {
	    + getDetails(input : any) : String
	    + getAmount(input : any) : Number
    }

    class MexicoGratification {
	    - daysCountedInYear : Number
	    - minimumDaysSalaryCountedInYear : Number
	    + initialize(minimumDaysSalaryCountedInYear : Number, daysCountedInYear : Number)
	    + getDetails(input : any) : String
	    + getAmount(input : any) : Number
	    + getGratification(dailySalary: Number, workedDaysYear : Number) : Number
    }

    class ChileGratification {
	    - maximumMonthlyLegalRatio : Number
	    - consideredMonths : Number
	    - rationOfAnnualRemuneration : Number
	    + initialize(ratioOfAnnualRemuneration : Number, consideredMonths : Number, maximumMonthlyLegalRatio : Number)
	    + getDetails(input : any) : String
	    + getAmount(input : any) : Number
	    + getBaseGratification(monthlyBaseSalary : Number) : Number
	    + getMinimumGratification(minimumMonthlyIncome : Number) : Number
    }

    class ColombiaGratification {
	    - daysCountedInYear : Number
	    + initialize(daysCountedInYear : Number)
	    + getDetails(input : any) : String
	    + getAmount(input : any) : Number
	    + getGratification(monthlySalary : Number, workedDaysSemester : Number) : Number
    }

	<<abstract>> View
	<<abstract>> GeneralGratification

    View <|-- ViewMexico
    View <|-- ViewChile
    View <|-- ViewColombia
    CountryGratification --> View : uses
    CountryGratification --> GeneralGratification : uses
    GeneralGratification <|-- MexicoGratification
    GeneralGratification <|-- ChileGratification
    GeneralGratification <|-- ColombiaGratification
    GratificationCountryFactory ..> CountryGratification : creates


