require 'debug'

class SurveyController < ApplicationController
  def base_survey
    @raw_cfg = File.read(Rails.root.join('config', 'factories.json'))
    @all_cfg = JSON.parse(@raw_cfg, symbolize_names: true)
    @country_options = @all_cfg.map { |code, data| [ data[:name], code.to_s ] }
  end
end
