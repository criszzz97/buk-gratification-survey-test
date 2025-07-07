class CountryGratification
    def initialize(currency="CLP",name="Chile",code="chile",gratificationImplementation,viewHandler)
        @currency = currency
        @name = name
        @code = code
        @gratificationImplementation = gratificationImplementation
        @viewHandler = viewHandler
    end    

    def getView
       @viewHandler.getView
    end

    def getDetails(params)
        @gratificationImplementation.getDetails(params)
    end

    def getAmount(params)
        @gratificationImplementation.getAmount(params)
    end

    def getCurrency
        return @currency
    end    


#    def getCurrency
#        raise NotImplementedError, "Subclasses must implement `getCurrency`"
#    end       
end