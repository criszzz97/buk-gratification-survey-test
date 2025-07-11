module ViewClasses
    class ViewMexico < View
        # Esta funcion pemrite ingresar en que ruta esta la vista que se desea renderizar.
        def initialize(baseViewFilePath:'survey/mexico_gratification')
            @baseViewFilePath = baseViewFilePath
        end

        # Esta funcion renderiza la vista de los campos de entrada asociados al pais Mexico.
        def getView
            fieldsView = ApplicationController.renderer.render(
            partial:  @baseViewFilePath
            )
            return fieldsView
        end    
    end
end
