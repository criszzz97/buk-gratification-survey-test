class GraficationCountryFactory
  # Este contructor inicializa la Clase Factory, con este metodo sobre todo se asignan los atributos de la clase.
  # La caracteristica mas importante de este metodo es que este lee el archivo de configuracion "factories.json", en base
  # al cual se instancian dinamicamente los distintos objetos que esta clase creara.
  def initialize
    @rawCfg = File.read(Rails.root.join('config', 'factories.json'))
    @allCfg = JSON.parse(@rawCfg, symbolize_names: true)
    @factoriesCode = "factories"
    @implModuleName = Object.const_get("GratificationImplementations")
    @viewModuleName = Object.const_get("ViewClasses")
  end  

  # Este metodo instancia de forma dinamica el pais correspondiente segun la entrada "countryCode", 
  # donde ademas en esta funcion se le inyectan las dependencias de implentacion y vista segun el archivo de configuracion "factories.json"
  def build(countryCode)
    countryCfg = @allCfg.dig(countryCode&.to_sym)
    factories = (countryCfg || {}).dig(@factoriesCode&.to_sym)
    if !countryCfg or !factories
      return nil
    end
    countryFactory = factories.select { |h| h[:isActive] }.max_by { |h| h[:version] }
    if countryFactory.nil?
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
