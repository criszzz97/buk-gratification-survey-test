module InputModels
    class MexicoGratificationInput
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :worked_days_year, :decimal
        attribute :daily_salary, :decimal

        validates :worked_days_year,  numericality: { greater_than: 0, message: "El número de días trabajados en el año no pueden ser menor o igual a 0" }
        validates :worked_days_year,  numericality: { less_than: 365, message: "El número de días trabajados en el año no pueden ser mayor a 365" }
        validates :daily_salary,   numericality: { greater_than: 0, message: "El salario diario no puede ser menor a cero" }

        def validate!
            valid? or raise ActiveModel::ValidationError.new(self)
        end    
    end

end