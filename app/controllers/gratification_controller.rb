class GratificationController < ApplicationController

  before_action :generateFactory

  # Esta funcion retorna la vista de las entradas renderizada asociada al pais recibido en los parametros (query parameter "country")
  def getView
    country = @factory.build(params[:country])
    html =  country&.getView() || ""
    render html: html.html_safe
  end

  # Esta funcion retorna un texto que contiene el desglose del caculo de gratificacion, esto para cada pais segun el parametro "country" recibido.
  def getDetails
    begin
      inputParam = params.require(:input)
      countryParam = inputParam[:country]
      return head :not_found unless countryParam
      country = @factory.build(countryParam)
      render json: {data: {details:country&.getDetails(inputParam) || "",currency:country&.getCurrency || "",amount:country&.getAmount(inputParam) || ""}}
      rescue ActiveModel::ValidationError => e
        render json: { validationErrors: e.model.errors.messages }, status: :unprocessable_entity
    end  
  end

  # Esta funcion instancia a la clase que aplica el metodo factory
  def generateFactory
    @factory = GraficationCountryFactory.new
  end


end
