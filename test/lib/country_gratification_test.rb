require "test_helper"
require "minitest/mock"

class CountryGratificationTest < ActiveSupport::TestCase
  def setup
    @fakeImpl = Minitest::Mock.new
    @fakeView = Minitest::Mock.new
  end

  def test_initialize_defaults
    cg = CountryGratification.new(@fakeImpl, @fakeView)
    assert_equal "CLP",   cg.getCurrency
    assert_equal "Chile", cg.getName
  end

  def test_initialize_with_custom_args
    cg = CountryGratification.new(
      "USD",            
      "Estados Unidos", 
      "usa",            
      @fakeImpl,
      @fakeView
    )
    assert_equal "USD",            cg.getCurrency
    assert_equal "Estados Unidos", cg.getName

    assert_equal @fakeImpl.object_id, cg.instance_variable_get(:@gratificationImplementation).object_id
    assert_equal @fakeView.object_id, cg.instance_variable_get(:@viewHandler).object_id
  end

  def test_get_view_delegates_to_view_handler
    @fakeView.expect(:getView, "<div>Fake View</div>")

    cg = CountryGratification.new("CUR", "name", "key", @fakeImpl, @fakeView)
    result = cg.getView

    assert_equal "<div>Fake View</div>", result
    @fakeView.verify
  end

  def test_getDetails_delegates_to_implementation
    input = { input: {country:"fake conuntry",fake_val1:1000,fake_val2:20} }
    @fakeImpl.expect(:getDetails, "DETAILS!", [input])

    cg = CountryGratification.new("CUR", "Name", "key", @fakeImpl, @fakeView)
    assert_equal "DETAILS!", cg.getDetails(input)
    @fakeImpl.verify
  end

  def test_getAmount_delegates_to_implementation
    input = { input: {country:"fake conuntry",fake_val1:1000,fake_val2:20} }
    @fakeImpl.expect(:getAmount, 100, [input])

    cg = CountryGratification.new("CUR", "Name", "key", @fakeImpl, @fakeView)
    assert_equal 100, cg.getAmount(input)
    @fakeImpl.verify
  end
end
