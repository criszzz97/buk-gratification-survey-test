require 'debug'

class GratificationController < ApplicationController

  def getView
    factory = GraficationCountryFactory.new
    country = factory.build(params[:country])
    html =  country.getView()
    render html: html.html_safe
  end


  def getDetails
    factory = GraficationCountryFactory.new
    country = factory.build(params.require(:input).require(:country))
    render json: {data: country.getDetails(params)}
  end


end
