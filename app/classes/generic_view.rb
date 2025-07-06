class View
    def getView
        raise NotImplementedError, "Subclasses must implement `getCurrency`"
    end 
end