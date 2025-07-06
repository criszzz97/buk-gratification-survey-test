class GraficationCountryFactory

  def build(country_code)
    case country_code
      when "chile"
        gratification_implementation = GratificationImplementations::ChileGratification.new
        view_implementation = ViewClasses::ViewChile.new
        country = ::CountryGratification.new("CLP","Chile","chile",gratification_implementation,view_implementation)
      when "colombia"
        gratification_implementation = GratificationImplementations::ColombiaGratification.new
        view_implementation = ViewClasses::ViewColombia.new
        country = ::CountryGratification.new("COP","Colombia","colombia",gratification_implementation,view_implementation)
      when "mexico"
        gratification_implementation = GratificationImplementations::MexicoGratification.new
        view_implementation = ViewClasses::ViewMexico.new
        country = ::CountryGratification.new("MXN","México","mexico",gratification_implementation,view_implementation)                     
      else
        gratification_implementation = GratificationImplementations::ChileGratification.new
        view_implementation = ViewClasses::ViewChile.new
        country = ::CountryGratification.new("CLP","Chile","chile",gratification_implementation,view_implementation)   
      end
    return country
  end
end  
