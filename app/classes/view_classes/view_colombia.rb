module ViewClasses
    class ViewColombia < View
        def initialize(baseViewFilePath=nil)
            @baseViewFilePath = baseViewFilePath
        end

        def getView
            fieldsView = ApplicationController.renderer.render(
            partial:  'survey/colombia_gratification'
            )
            return fieldsView
        end    
    end
end
