class GraficationCountryFactory
  def initialize
    @raw_cfg = File.read(Rails.root.join('config', 'factories.json'))
    @all_cfg = JSON.parse(@raw_cfg, symbolize_names: true)
    @factories_code = "factories"
    @impl_module_name = Object.const_get("GratificationImplementations")
    @view_module_name = Object.const_get("ViewClasses")
  end  

  def build(country_code)
    country_cfg = @all_cfg[country_code.to_sym || "chile"] 
    factories = country_cfg[@factories_code.to_sym]
    country_factory = factories.select { |h| h[:isActive] }.max_by { |h| h[:version] }
    if !country_factory
      Rails.logger.error "❌ No country factory was found for the country code #{country_code || "chile"}"
      raise "No valid factory was found for the country code #{country_code || "chile"}"
    end  
    gratification_implementation_class = @impl_module_name.const_get(country_factory[:injects][:implementation_class])
    gratification_implementation_inputs = country_factory[:injects][:implementation_inputs]
    view_implementation_class = @view_module_name.const_get(country_factory[:injects][:view_class])
    view_implementation_inputs = country_factory[:injects][:view_inputs]
    gratification_implementation = gratification_implementation_class.new(**gratification_implementation_inputs)
    view_implementation = view_implementation_class.new(**view_implementation_inputs)
    country = ::CountryGratification.new(country_cfg[:currency],country_cfg[:name],country_cfg[:code],gratification_implementation,view_implementation)
    Rails.logger.info    "✅ The object country (#{country.getName}) was instantiated sucessfully"
    return country
  end
end  
