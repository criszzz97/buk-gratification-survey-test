Rails.application.routes.draw do
  root to: 'survey#base_survey'
  get "survey" => "survey#base_survey", as: :base_survey
  get "gratification/survey/fields" => "gratification#getView", as: :survey_gratification
  post "gratification/details" => "gratification#getDetails", as: :calculate_gratification
end
