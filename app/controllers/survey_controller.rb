class SurveyController < ApplicationController
  # Esta funcion del controlador permite redirigir la ruta "survey" (raiz) y renderizar la vista base del formulario.
  def base_survey
    @rawCfg = File.read(Rails.root.join('config', 'factories.json'))
    @allCfg = JSON.parse(@rawCfg, symbolize_names: true)
    @countryOptions = @allCfg.map { |code, data| [ data[:name], code.to_s ] }
    rescue StandardError => e
      Rails.logger.error "❌ The base survey couldnt be loaded"
      render json: { message: "Base survey couldnt be loaded", error:e }, status: :internal_server_error
  end
end
