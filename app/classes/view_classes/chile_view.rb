class ViewChile
    def initialize(baseViewFilePath=nil)
        @baseViewFilePath = baseViewFilePath
    end

    def getView()

        fieldsView = ApplicationController.renderer.render(
        partial:  'surveys/chile_gratification'
        )
        return fieldsView
    end    
end