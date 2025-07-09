class CountryGratification
    def initialize(currency="CLP",name="Chile",code="chile",gratificationImplementation,viewHandler)
        @currency = currency
        @name = name
        @code = code
        @gratificationImplementation = gratificationImplementation
        @viewHandler = viewHandler
    end    

    def getView
       return @viewHandler.getView
    end

    def getDetails(input)
        return @gratificationImplementation.getDetails(input)
    end

    def getAmount(input)
        return @gratificationImplementation.getAmount(input)
    end

    def getCurrency
        return @currency
    end    
  
end