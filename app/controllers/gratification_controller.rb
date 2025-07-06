require 'debug'

class GratificationController < ApplicationController

  def getView
    factory = GraficationCountryFactory.new
    country = factory.build(params[:country])
    html =  country.getView()
    render html: html.html_safe
  end

end
