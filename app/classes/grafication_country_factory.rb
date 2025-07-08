class GraficationCountryFactory
  def initialize
    @raw_cfg = File.read(Rails.root.join('config', 'factories.json'))
    @all_cfg = JSON.parse(@raw_cfg)
    @factories_code = "factories"
    @impl_module_name = Object.const_get("GratificationImplementations")
    @view_module_name = Object.const_get("ViewClasses")
  end  

  def build(country_code)

    country_cfg = @all_cfg[country_code || "chile"] 
    factories = country_cfg[@factories_code]
    country_factory = factories.select { |h| h["isActive"] }.max_by { |h| h["version"] }
    gratification_implementation_class = @impl_module_name.const_get(country_factory["injects"]["implementation_class"])
    view_implementation_class = @view_module_name.const_get(country_factory["injects"]["view_class"])
    gratification_implementation = gratification_implementation_class.new
    view_implementation = view_implementation_class.new
    country = ::CountryGratification.new(country_cfg["currency"],country_cfg["name"],country_cfg["code"],gratification_implementation,view_implementation)
    return country

    return country_factory
  end
end  
