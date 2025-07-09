require 'debug'

class GratificationController < ApplicationController

  before_action :generateFactory

  def getView
    country = @factory.build(params[:country])
    html =  country&.getView() || ""
    render html: html.html_safe
  end


  def getDetails
    countryParam = params.require(:input).require(:country)
    puts countryParam
    return head :not_found unless countryParam
    country = @factory.build(countryParam)
    render json: {data: {details:country.getDetails(params.require(:input)),currency:country.getCurrency,amount:country.getAmount(params.require(:input))}}
  end

  def generateFactory
    @factory = GraficationCountryFactory.new
  end


end
