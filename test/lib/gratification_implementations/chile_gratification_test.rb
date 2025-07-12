require "test_helper"

module GratificationImplementations
  class ChileGratificationTest < ActiveSupport::TestCase
    def test_initialize_defaults
      g = ChileGratification.new
      assert_in_delta 0.25, g.instance_variable_get(:@ratioOfAnnualRemuneration), 1e-8
      assert_equal    12,   g.instance_variable_get(:@consideredMonths)
      assert_in_delta 4.75, g.instance_variable_get(:@maximumMonthlyLegalRatio), 1e-8
    end

    def test_initialize_invalid_ratio
      assert_raises(RuntimeError) { ChileGratification.new(ratioOfAnnualRemuneration: 0) }
      assert_raises(RuntimeError) { ChileGratification.new(ratioOfAnnualRemuneration: 1.1) }
    end

    def test_initialize_invalid_months
      assert_raises(RuntimeError) { ChileGratification.new(consideredMonths: 0) }
      assert_raises(RuntimeError) { ChileGratification.new(consideredMonths: 13) }
    end

    def test_initialize_invalid_maximum_ratio
      assert_raises(RuntimeError) { ChileGratification.new(maximumMonthlyLegalRatio: 0) }
    end

    def test_get_base_gratification
      g = ChileGratification.new(ratioOfAnnualRemuneration: 0.2, consideredMonths: 10)
      expected = 1000 * 10 * 0.2
      assert_in_delta expected, g.getBaseGratification(1000), 1e-8
    end

    def test_get_minimum_gratification
      g = ChileGratification.new(maximumMonthlyLegalRatio: 5)
      assert_equal 200 * 5, g.getMinimumGratification(200)
    end

    def test_get_amount_with_valid_input
      g = ChileGratification.new
      input = { monthly_base_salary: 1200000, minimum_monthly_income: 460000 }
      expected = 2185000
      assert_equal expected, g.getAmount(input)
      input = { monthly_base_salary: 700000, minimum_monthly_income: 460000 }
      expected = 2100000
      assert_equal expected, g.getAmount(input)
    end

    def test_get_amount_raises_on_invalid_input
      g = ChileGratification.new
      assert_raises(ActiveModel::ValidationError) { g.getAmount({}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_base_salary: nil, minimum_monthly_income: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_base_salary: -1, minimum_monthly_income: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_base_salary: nil, minimum_monthly_income: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_base_salary: -1, minimum_monthly_income: -1}) }
    end

    def test_get_details_with_valid_input
      g = ChileGratification.new
      input = { monthly_base_salary: 1200000, minimum_monthly_income: 460000 }
      expected = "Desglose: 25% del sueldo anual ($3600000), tope legal ($2185000). Se paga el menor."
      assert_equal expected, g.getDetails(input)
      input = { monthly_base_salary: 700000, minimum_monthly_income: 460000 }
      expected = "Desglose: 25% del sueldo anual ($2100000), tope legal ($2185000). Se paga el menor."
      assert_equal expected, g.getDetails(input)
    end

    def test_get_details_raises_on_invalid_input
      g = ChileGratification.new
      assert_raises(ActiveModel::ValidationError) { g.getDetails({}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_base_salary: nil, minimum_monthly_income: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_base_salary: -1, minimum_monthly_income: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_base_salary: nil, minimum_monthly_income: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_base_salary: -1, minimum_monthly_income: -1}) }
    end
  end
end
