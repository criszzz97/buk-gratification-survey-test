# Esta clase representa de forma general a un pais y sus procesos asociados a las gratificaciones
class CountryGratification
    # Este constructor permite ingresar la moneda, el nombre, el codigo, el objeto que implementa el 
    # calculo de gratificaciones y el objeto que maneja la vista de las entradas del formulario.
    def initialize(currency="CLP",name="Chile",code="chile",gratificationImplementation,viewHandler)
        @currency = currency
        @name = name
        @code = code
        @gratificationImplementation = gratificationImplementation
        @viewHandler = viewHandler
    end

    # Este metodo pemite obtener la vista renderizada de las entradas del formulario asociadas al pais, esto en base a la depndencia @viewHandler.
    def getView
       viewResult = @viewHandler.getView
       Rails.logger.info  "✅ The view for the country #{self.getName} was succesfully processed by the view class #{@viewHandler.class.name}"
       return viewResult
    end

    # Este metodo retorna el nombre del pais.
    def getName
        return @name
    end    

    # Esta funcion recibe como input los datos ingresados por el usuario y retorna un texto que contiene el desglose del caculo de gratificacion, esto en base a la dependencia @gratificationImplementation.
    def getDetails(input)
        result = @gratificationImplementation.getDetails(input)
        Rails.logger.info  "✅ The details calculation (#{result}) for the country #{self.getName} was succesfully processed with the following input #{input} by the implementation of class #{@gratificationImplementation.class.name}"
        return result
    end

    # Esta funcion recibe como input los datos ingresados por el usuario y retorna el monto de gratificacion cálculado a partir de los datos de entrada, esto en base a la dependencia @gratificationImplementation.
    def getAmount(input)
        amountResult = @gratificationImplementation.getAmount(input)
        Rails.logger.info  "✅ The amount (#{amountResult.to_s}) for the country #{self.getName} was succesfully processed with the following input #{input} by the implementation of class #{@gratificationImplementation.class.name}"
        return amountResult
    end

    # Este metodo retorna el codigo de la moneda del pais.
    def getCurrency
        return @currency
    end    
  
end
