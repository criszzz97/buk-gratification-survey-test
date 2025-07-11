module InputModels
    class ChileGratificationInput
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :monthly_base_salary, :decimal
        attribute :minimum_monthly_income, :decimal

        validates :monthly_base_salary,  numericality: { greater_than: 0, message: "El sueldo base mensual no puede ser menor a cero" }
        validates :minimum_monthly_income,   numericality: { greater_than: 0, message: "El ingreso mínimo mensual no puede ser menor a cero" }
        
        def validate!
            valid? or raise ActiveModel::ValidationError.new(self)
        end
    end

end