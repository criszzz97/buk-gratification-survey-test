class GeneralGratification
    def getDetails(input)
        raise NotImplementedError, "Subclasses must implement `getDetails`"
    end

    def getAmount(input)
        raise NotImplementedError, "Subclasses must implement `getAmount`"
    end  
end
