class CountryGratification
    def initialize(currency="CLP",name="Chile",code="chile",gratificationImplementation,viewHandler)
        @currency = currency
        @name = name
        @code = code
        @gratificationImplementation = gratificationImplementation
        @viewHandler = viewHandler
    end    

    def getView
       viewResult = @viewHandler.getView
       Rails.logger.info  "✅ The view for the country #{self.getName} was succesfully processed by the view class #{@viewHandler.class.name}"
       return viewResult
    end

    def getName
        return @name
    end    

    def getDetails(input)
        result = @gratificationImplementation.getDetails(input)
        Rails.logger.info  "✅ The details calculation (#{result}) for the country #{self.getName} was succesfully processed with the following input #{input} by the implementation of class #{@gratificationImplementation.class.name}"
        return result
    end

    def getAmount(input)
        amountResult = @gratificationImplementation.getAmount(input)
        Rails.logger.info  "✅ The amount (#{amountResult.to_s}) for the country #{self.getName} was succesfully processed with the following input #{input} by the implementation of class #{@gratificationImplementation.class.name}"
        return amountResult
    end

    def getCurrency
        return @currency
    end    
  
end