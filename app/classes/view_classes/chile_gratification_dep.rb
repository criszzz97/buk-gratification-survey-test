class ChileGratification < CountryGratification
    def initialize
        @country = "chile"
    end    

    def getViewPath
        return "surveys/_#{@country}_gratification"
    end

    def getDetails
        raise NotImplementedError, "Subclasses must implement `getDetails`"
    end

    def getAmount
        raise NotImplementedError, "Subclasses must implement `getAmount`"
    end

    def getCurrency
        raise NotImplementedError, "Subclasses must implement `getCurrency`"
    end    
end 