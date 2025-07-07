module InputModels
    class ChileGratificationInput
        include ActiveModel::Model
        include ActiveModel::Attributes

        attribute :IngresoMinimo, :decimal
        attribute :SueldoBase, :decimal

        validates :IngresoMinimo,  numericality: { greater_than: 0 }
        validates :SueldoBase,   numericality: { greater_than: 0 }

    end
end