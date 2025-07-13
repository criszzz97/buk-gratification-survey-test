require "test_helper"

class GratificationControllerTest < ActionController::TestCase
  # Evita que el before_action genere una fábrica real
  setup do
    @factory = GraficationCountryFactory.new


    @chileHtmlView = '<div class="form-group" data-dynamic-field="true">
    <label for="base_salary_label">Sueldo base mensual</label>
    <input type="number" class="form-control" id="monthly_base_salary" name="monthly_base_salary" data-dynamic-input="true">
  </div>
  <div class="form-group" data-dynamic-field="true">
    <label for="minimum_income_label">Ingreso mínimo mensual</label>
    <input type="number" class="form-control" id="minimum_monthly_income" name="minimum_monthly_income" data-dynamic-input="true">
  </div>'

    @colombiaHtmlView = '<div class="form-group" data-dynamic-field="true">
    <label for="monthly_salary_label">Salario mensual</label>
    <input type="number" class="form-control" id="monthly_salary" name="monthly_salary" data-dynamic-input="true">
  </div>
  <div class="form-group" data-dynamic-field="true">
    <label for="worked_days_semester_label">Días trabajados en el semestre</label>
    <input type="number" class="form-control" id="worked_days_semester" name="worked_days_semester" data-dynamic-input="true">
  </div>'

    @mexicoHtmlView = '<div class="form-group" data-dynamic-field="true">
    <label for="daily_salary_label">Salario diario</label>
    <input type="number" class="form-control" id="daily_salary" name="daily_salary" data-dynamic-input="true">
  </div>
  <div class="form-group" data-dynamic-field="true">
    <label for="worked_days_year_label">Días trabajados en el año</label>
    <input type="number" class="form-control" id="worked_days_year" name="worked_days_year" data-dynamic-input="true">
  </div>'
  end


  def test_get_view_html_depending_on_country

    countries = [
        { expectedHTML: @chileHtmlView,   country: "chile"   },
        { expectedHTML: @colombiaHtmlView, country: "colombia"},
        { expectedHTML: @mexicoHtmlView,   country: "mexico"  },
    ]

    countries.each do |country|
        get :getView, params: { country: country[:country] }
        assert_response :success
        assert_equal country[:expectedHTML].squish, @response.body.squish.strip
    end
  end

  def test_view_return_empty_string_if_unkown_country
    country = "peru"
    get :getView, params: { country: country }
    assert_response :success
    assert_equal "",@response.body.squish.strip
  end

  def test_get_details_return_json_with_correct_values

    countries = [
        {expectedReturnJson:{data:{details:"Desglose: 25% del sueldo anual ($3600000), tope legal ($2185000). Se paga el menor.",currency:"CLP",amount:2185000}},country: "chile",input:{monthly_base_salary: 1200000, minimum_monthly_income: 460000, country: "chile"}},
        {expectedReturnJson:{data:{details:"Desglose: ($2000000x90)/360 = $500000",currency:"COP",amount:500000}}, country: "colombia", input:{monthly_salary: 2000000, worked_days_semester: 90, country: "colombia"}},
        {expectedReturnJson:{data:{details:"Desglose: Salario diario ($1000) x 15 días = $15000",currency:"MXN",amount:15000}}, country: "mexico", input:{daily_salary: 1000, worked_days_year: 365, country: "mexico"}}
    ]


    countries.each do |country|
        post :getDetails,
        params: {input: country[:input]},
        as: :json

        assert_response :success
        actual = JSON.parse(@response.body).deep_symbolize_keys

        assert_equal country[:expectedReturnJson], actual
    end
  end

  def test_get_details_404_country_not_found
    post :getDetails, params: { input: { country: nil } }, as: :json
    assert_response :not_found
  end

  def test_get_details_validation_errors

    countries = [
        {expectedReturnJson:{validationErrors:{minimum_monthly_income: ["El ingreso mínimo mensual no puede ser menor a cero"]}},country: "chile",input:{monthly_base_salary: 1200000, minimum_monthly_income: -1, country: "chile"}},
        {expectedReturnJson:{validationErrors:{monthly_salary: ["El salario mensual no puede ser menor a cero"]}}, country: "colombia", input:{monthly_salary: -1, worked_days_semester: 100, country: "colombia"}},
        {expectedReturnJson:{validationErrors:{worked_days_year: ["El número de días trabajados en el año no pueden ser mayor a 365"]}}, country: "mexico", input:{daily_salary: 1000, worked_days_year: 400, country: "mexico"}}
    ]


    countries.each do |country|
        post :getDetails,
        params: {input: country[:input]},
        as: :json

        assert_response :unprocessable_entity
        actual = JSON.parse(@response.body).deep_symbolize_keys

        assert_equal country[:expectedReturnJson], actual
    end
  end

end
