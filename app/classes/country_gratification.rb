class CountryGratification
    def initialize(currency="CLP",name="Chile",code="chile",gratificationImplementation,viewPathFinder)
        @currency = currency
        @name = name
        @code = code
    end    

    def getViewPath
       viewPathFinder.getPath
    end

    def getDetails
        gratificationImplementation.getDetails(params)
    end

    def getAmount(params)
        gratificationImplementation.getAmount(params)
    end

    def getCurrency
        return @currency
    end    


#    def getCurrency
#        raise NotImplementedError, "Subclasses must implement `getCurrency`"
#    end       
end