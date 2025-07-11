class View
    # Esta funcion, asociada a esta clase abstracta, renderiza la vista de los campos de entrada.
    def getView
        raise NotImplementedError, "Subclasses must implement `getView`"
    end 
end

