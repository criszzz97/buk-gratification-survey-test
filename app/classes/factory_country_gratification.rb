class GraficationCountryFactory

  def build(country_code)
    case country_code
    when "chile"
      gratification_implementation = ChileGratification.new
      view_implementation = ViewChile.new
      country = CountryGratification.new("CLP","Chile","chile",gratification_implementation,view_implementation)
#    when "colombia"
#      gratification_implementation = ColombiaGratification.new
#      view_implementation = ViewColombia.new
#      country = CountryGratification.new("COP","Colombia","colombia",gratification_implementation,view_implementation)  
#    when "mexico"
#      gratification_implementation = MexicoGratification.new
#      view_implementation = ViewMexico.new
#      country = CountryGratification.new("MXN","México","mexico",gratification_implementation,view_implementation)        
    else
      gratification_implementation = ChileGratification.new
      view_implementation = ViewChile.new
      country = CountryGratification.new("CLP","Chile","chile",gratification_implementation,view_implementation)   
    end
    return country
  end
end  