require "test_helper"

module GratificationImplementations
  class ColombiaGratificationTest < ActiveSupport::TestCase
    def test_initialize_defaults
      g = ColombiaGratification.new
      assert_in_delta 360, g.instance_variable_get(:@daysCountedInYear)
    end

    def test_initialize_invalid_days_counted_in_year
      assert_raises(RuntimeError) { ColombiaGratification.new(daysCountedInYear: -1) }
      assert_raises(RuntimeError) { ColombiaGratification.new(daysCountedInYear: 400) }
    end

    def test_get_gratification
      g = ColombiaGratification.new
      expected = ((2000000 * 180)/360).to_i
      assert_in_delta expected, g.getGratification(2000000,180), 1e-8
    end


    def test_get_amount_with_valid_input
      g = ColombiaGratification.new
      input = { monthly_salary: 2000000, worked_days_semester: 180 }
      assert_equal 1000000, g.getAmount(input)
      input = { monthly_salary: 2000000, worked_days_semester: 90 }
      assert_equal 500000, g.getAmount(input)
    end

    def test_get_amount_raises_on_invalid_input
      g = ColombiaGratification.new
      assert_raises(ActiveModel::ValidationError) { g.getAmount({}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_salary: nil, worked_days_semester: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_salary: -1, worked_days_semester: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_salary: nil, worked_days_semester: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_salary: -1, worked_days_semester: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getAmount({monthly_salary: 1000, worked_days_semester: 400}) }
    end

    def test_get_details_with_valid_input
      g = ColombiaGratification.new
      input = { monthly_salary: 2000000, worked_days_semester: 180 }
      expected = "Desglose: ($2000000x180)/360 = $1000000"
      assert_equal expected, g.getDetails(input)
      input = { monthly_salary: 2000000, worked_days_semester: 90 }
      expected = "Desglose: ($2000000x90)/360 = $500000"
      assert_equal expected, g.getDetails(input)
    end

    def test_get_details_raises_on_invalid_input
      g = ColombiaGratification.new
      assert_raises(ActiveModel::ValidationError) { g.getDetails({}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_salary: nil, worked_days_semester: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_salary: -1, worked_days_semester: nil}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_salary: nil, worked_days_semester: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_salary: -1, worked_days_semester: -1}) }
      assert_raises(ActiveModel::ValidationError) { g.getDetails({monthly_salary: 1000, worked_days_semester: 400}) }
    end
  end
end
