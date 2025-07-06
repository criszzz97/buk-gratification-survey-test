require_dependency Rails.root.join("app/classes/country_classes/chile_gratification")
binding.break 
class GratificationController < ApplicationController
#  def getView
#    puts("holaa")
#    render ChileGratification.new.getViewPath
#  end


  def getView
    binding.break
    GraficationCountryFactory.new
    country = GraficationCountryFactory.build("chile")
    return country.getView()
  end


GraficationCountryFactory
end
