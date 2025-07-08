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
    render json: {data: {details:country.getDetails(params.require(:input)),currency:country.getCurrency,amount:country.getAmount(params.require(:input))}}
  end


end
