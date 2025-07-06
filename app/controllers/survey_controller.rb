require 'debug'

class SurveyController < ApplicationController
  def getView
    binding.break
    puts("holaa")
    render "surveys/_survey"
  end
end
