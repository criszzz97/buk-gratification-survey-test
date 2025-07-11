module InputModels
    class ChileGratificationInput < ModelGratificationInput
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :monthly_base_salary, :decimal
        attribute :minimum_monthly_income, :decimal

        validates :monthly_base_salary,  numericality: { greater_than: 0, message: "El sueldo base mensual no puede ser menor a cero" }
        validates :minimum_monthly_income,   numericality: { greater_than_or_equal_to: 0, message: "El ingreso mínimo mensual no puede ser menor a cero" }
    end

end
