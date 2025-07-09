module ViewClasses
    class ViewColombia < View
        def initialize(baseViewFilePath:'survey/colombia_gratification')
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
