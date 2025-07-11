class GraficationCountryFactory
  def initialize
    @rawCfg = File.read(Rails.root.join('config', 'factories.json'))
    @allCfg = JSON.parse(@rawCfg, symbolize_names: true)
    @factoriesCode = "factories"
    @implModuleName = Object.const_get("GratificationImplementations")
    @viewModuleName = Object.const_get("ViewClasses")
  end  

  def build(countryCode)
    countryCfg = @allCfg[countryCode.to_sym || "chile"] 
    factories = countryCfg[@factoriesCode.to_sym]
    countryFactory = factories.select { |h| h[:isActive] }.max_by { |h| h[:version] }
    if !countryFactory
      Rails.logger.error "❌ No country factory was found for the country code #{countryCode || "chile"}"
      raise "No valid factory was found for the country code #{countryCode || "chile"}"
    end  
    gratificationImplementationClass = @implModuleName.const_get(countryFactory[:injects][:implementation_class])
    gratificationImplementationInputs = countryFactory[:injects][:implementation_inputs]
    viewImplementationClass = @viewModuleName.const_get(countryFactory[:injects][:view_class])
    viewImplementationInputs = countryFactory[:injects][:view_inputs]
    gratificationImplementation = gratificationImplementationClass.new(**gratificationImplementationInputs)
    viewImplementation = viewImplementationClass.new(**viewImplementationInputs)
    country = ::CountryGratification.new(countryCfg[:currency],countryCfg[:name],countryCfg[:code],gratificationImplementation,viewImplementation)
    Rails.logger.info    "✅ The object country (#{country.getName}) was instantiated sucessfully"
    return country
  end
end  
