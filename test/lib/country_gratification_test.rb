require "test_helper"

class CountryGratificationTest < ActiveSupport::TestCase
  def setup

    @chileGratificationImplementation = GratificationImplementations::ChileGratification.new
    @colombiaGratificationImplementation = GratificationImplementations::ColombiaGratification.new
    @mexicoGratificationImplementation = GratificationImplementations::MexicoGratification.new
    
    @chileGratificaionView = ViewClasses::ViewChile.new
    @colombiaGratificaionView = ViewClasses::ViewColombia.new
    @mexicoGratificaionView = ViewClasses::ViewMexico.new

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

  def test_initialize_defaults
    cg = CountryGratification.new(@fake_impl, @fake_view)
    assert_equal "CLP",   cg.getCurrency
    assert_equal "Chile", cg.getName
  end

  def test_initialize_with_custom_args
    cg = CountryGratification.new("USD", "Estados Unidos", "usa", @chileGratificationImplementation, @chileGratificaionView)
    assert_equal "USD",               cg.getCurrency
    assert_equal "Estados Unidos",    cg.getName
    assert_same @chileGratificationImplementation, cg.instance_variable_get(:@gratificationImplementation)
    assert_same @chileGratificaionView, cg.instance_variable_get(:@viewHandler)
  end

  def test_get_view_delegates_to_view_handler
    countries = [
        {expectedHTML:@chileHtmlView,country:CountryGratification.new("CLP","Chile","chile", @chileGratificationImplementation, @chileGratificaionView)},
        {expectedHTML:@colombiaHtmlView, country: CountryGratification.new("COP","Colombia","colombia", @colombiaGratificationImplementation, @colombiaGratificaionView)},
        {expectedHTML:@mexicoHtmlView, country: CountryGratification.new("MXN","México","mexico", @mexicoGratificationImplementation, @mexicoGratificaionView)},
    ]

    countries.each do |country|
        assert_equal country[:expectedHTML].strip, country[:country].getView.strip
    end
  end

  def test_get_details_delegates_to_impl
    countries = [
        {returnDetail:"Desglose: 25% del sueldo anual ($3600000), tope legal ($2185000). Se paga el menor.",country:CountryGratification.new("CLP","Chile","chile", @chileGratificationImplementation, @chileGratificaionView),input:{monthly_base_salary: 1200000, minimum_monthly_income: 460000}},
        {returnDetail:"Desglose: ($2000000x90)/360 = $500000", country: CountryGratification.new("COP","Colombia","colombia", @colombiaGratificationImplementation, @colombiaGratificaionView), input:{monthly_salary: 2000000, worked_days_semester: 90}},
        {returnDetail:"Desglose: Salario diario ($1000) x 15 días = $15000", country: CountryGratification.new("MXN","México","mexico", @mexicoGratificationImplementation, @mexicoGratificaionView), input:{daily_salary: 1000, worked_days_year: 365}},
    ]

    countries.each do |country|
        assert_equal country[:returnDetail], country[:country].getDetails(country[:input])
    end
  end

  def test_get_amount_delegates_to_impl
    countries = [
        {returnAmount:2185000,country:CountryGratification.new("CLP","Chile","chile", @chileGratificationImplementation, @chileGratificaionView),input:{monthly_base_salary: 1200000, minimum_monthly_income: 460000}},
        {returnAmount:500000, country: CountryGratification.new("COP","Colombia","colombia", @colombiaGratificationImplementation, @colombiaGratificaionView), input:{monthly_salary: 2000000, worked_days_semester: 90}},
        {returnAmount:15000, country: CountryGratification.new("MXN","México","mexico", @mexicoGratificationImplementation, @mexicoGratificaionView), input:{daily_salary: 1000, worked_days_year: 365}},
    ]

    countries.each do |country|
        assert_equal country[:returnAmount], country[:country].getAmount(country[:input])
    end
  end
end
