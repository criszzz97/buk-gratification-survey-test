module InputModels
    class ModelGratificationInput
        def validate!
            valid? or raise ActiveModel::ValidationError.new(self)
        end    
    end
end
