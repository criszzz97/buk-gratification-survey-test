class GratificationController < ApplicationController

  before_action :generateFactory

  def getView
    country = @factory.build(params[:country])
    html =  country&.getView() || ""
    render html: html.html_safe
  end


  def getDetails
    inputParam = params.require(:input)
    countryParam = inputParam.require(:country)
    return head :not_found unless countryParam
    country = @factory.build(countryParam)
    render json: {data: {details:country.getDetails(inputParam),currency:country.getCurrency,amount:country.getAmount(inputParam)}}
  end

  def generateFactory
    @factory = GraficationCountryFactory.new
  end


end
