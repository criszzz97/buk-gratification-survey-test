module ViewClasses
    class ViewMexico < View
        def initialize(baseViewFilePath=nil)
            @baseViewFilePath = baseViewFilePath
        end

        def getView
            fieldsView = ApplicationController.renderer.render(
            partial:  'survey/mexico_gratification'
            )
            return fieldsView
        end    
    end
end