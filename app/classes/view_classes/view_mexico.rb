module ViewClasses
    class ViewMexico < View
        def initialize(baseViewFilePath:'survey/mexico_gratification')
            @baseViewFilePath = baseViewFilePath
        end

        def getView
            fieldsView = ApplicationController.renderer.render(
            partial:  @baseViewFilePath
            )
            return fieldsView
        end    
    end
end
