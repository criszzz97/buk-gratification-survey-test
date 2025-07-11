module InputModels
    class ColombiaGratificationInput
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :worked_days_semester, :decimal
        attribute :monthly_salary, :decimal

        validates :worked_days_semester,  numericality: { greater_than: 0, message: "El número de días trabajados en el semestre no pueden ser menor o igual a 0" }
        validates :worked_days_semester,  numericality: { less_than: 183, message: "El número de días trabajados en el semestre no pueden ser mayor a 183" }
        validates :monthly_salary,   numericality: { greater_than: 0, message: "El salario mensual no puede ser menor a cero" }

        def validate!
            valid? or raise ActiveModel::ValidationError.new(self)
        end    
    end

end