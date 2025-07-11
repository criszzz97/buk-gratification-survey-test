# Esta clase abstracta representa los metodos mas importantes que deben tener las implementaciones de gratificaiones y que deben necesariamente sobreescribir de forma particular
class GeneralGratification

    # Esta funcion a modo general recibe como input los datos ingresados por el usuario y debe retornar un texto que contiene el desglose del caculo de gratificacion.
    def getDetails(input)
        raise NotImplementedError, "Subclasses must implement `getDetails`"
    end

    # Esta funcion a modo general recibe como input los datos ingresados por el usuario y retorna el monto de gratificacion cálculado a partir de los datos de entrada.
    def getAmount(input)
        raise NotImplementedError, "Subclasses must implement `getAmount`"
    end  
end
