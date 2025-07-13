require "test_helper"

class GraficationCountryFactoryTest < ActiveSupport::TestCase
  def setup
    
    @factory = GraficationCountryFactory.new

  end

  def test_initialize_defaults
    allCfg = File.read(Rails.root.join('config', 'factories.json'))
    assert_equal allCfg,   @factory.instance_variable_get(:@rawCfg)
    assert_equal JSON.parse(allCfg, symbolize_names: true), @factory.instance_variable_get(:@allCfg)
    assert_equal "factories", @factory.instance_variable_get(:@factoriesCode)
    assert_equal Object.const_get("GratificationImplementations"), @factory.instance_variable_get(:@implModuleName)
    assert_equal Object.const_get("ViewClasses"), @factory.instance_variable_get(:@viewModuleName)
  end

  def test_build_with_nil_country_code
    expected = nil
    assert_nil expected, @factory.build(nil)
  end

  def test_build_with_a_country_with_no_factories
    fakeCfg = { canada: {} }
    @factory.instance_variable_set(:@allCfg, fakeCfg)
    assert_nil @factory.build("canada")
  end

  def test_build_with_a_country_with_no_factories_actives
    fakeCfg = { canada: {factories:[{version:1,isActive: false}]} }
    @factory.instance_variable_set(:@allCfg, fakeCfg)
    err = assert_raises(RuntimeError) { @factory.build("canada") }
    assert_match(/No valid factory was found for the country code canada/, err.message)
  end

  def test_build_with_valid_country_input
    countries = [
        {country:"chile",currency: "CLP",name: "Chile"},
        {country: "colombia", currency: "COP", name: "Colombia"},
        {country: "mexico", currency: "MXN", name: "México"},
    ]

    countries.each do |country|
        countryInstance = @factory.build(country[:country])
        assert_equal country[:country], countryInstance.instance_variable_get(:@code)
        assert_equal country[:currency], countryInstance.instance_variable_get(:@currency)
        assert_equal country[:name], countryInstance.instance_variable_get(:@name)
    end
  end
end
