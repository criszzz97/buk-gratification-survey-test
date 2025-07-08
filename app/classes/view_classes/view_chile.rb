module ViewClasses
    class ViewChile < View
        def initialize(baseViewFilePath='survey/chile_gratification')
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