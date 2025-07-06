module ViewClasses
    class ViewChile < View
        def initialize(baseViewFilePath=nil)
            @baseViewFilePath = baseViewFilePath
        end

        def getView
            fieldsView = ApplicationController.renderer.render(
            partial:  'survey/chile_gratification'
            )
            return fieldsView
        end    
    end
end