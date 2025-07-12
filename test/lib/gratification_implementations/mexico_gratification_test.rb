require "test_helper"

module GratificationImplementations
  class MexicoGratificationTest < ActiveSupport::TestCase
    def test_initialize_defaults
      g = MexicoGratification.new
      assert_equal 365, g.instance_variable_get(:@daysCountedInYear)
      assert_equal 15, g.instance_variable_get(:@minimumDaysSalaryCountedInYear)
    end

    def test_initialize_invalid_days_counted_in_year
      assert_raises(RuntimeError) { MexicoGratification.new(daysCountedInYear: -1) }
      assert_raises(RuntimeError) { MexicoGratification.new(daysCountedInYear: 400) }
    end

    def test_initialize_invalid_minimmum_days_salary_counted_in_year
        assert_raises(RuntimeError) { MexicoGratification.new(minimumDaysSalaryCountedInYear: -1) }
    end

    def test_get_gratification
      g = MexicoGratification.new
      dailySalary = 1000
      workedDaysInYear = 365
      expected = dailySalary * 15 * (workedDaysInYear/365)
      assert_equal expected, g.getGratification(dailySalary,workedDaysInYear)
    end

    def test_get_amount_with_valid_input
      g = MexicoGratification.new
      input = { daily_salary: 1000, worked_days_year: 365 }
      assert_equal 15000, g.getAmount(input)
      input = { daily_salary: 1000, worked_days_year: 180 }
      assert_equal 7397, g.getAmount(input)
    end

    def test_get_amount_raises_on_invalid_input
      g = MexicoGratification.new
      assert_raises(ActiveModel::ValidationError) { g.getAmount({}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({daily_salary: nil, worked_days_year: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({daily_salary: -1, worked_days_year: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({daily_salary: nil, worked_days_year: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({daily_salary: -1, worked_days_year: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({daily_salary: 1000, worked_days_year: 400}) }
    end

    def test_get_details_with_valid_input
      g = MexicoGratification.new
      input = { daily_salary: 1000, worked_days_year: 365 }
      expected = "Desglose: Salario diario ($1000) x 15 días = $15000"
      assert_equal expected, g.getDetails(input)
      input = { daily_salary: 1000, worked_days_year: 180 }
      expected = "Desglose: Salario diario ($1000) x 15 días x (180/365) = $7397"
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
