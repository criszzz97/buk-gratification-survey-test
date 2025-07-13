require "test_helper"

module ViewClasses
  class ViewMexicoTest < ActiveSupport::TestCase
    def setup
      @realHtmlExpected = '<div class="form-group" data-dynamic-field="true">
      <label for="daily_salary_label">Salario diario</label>
      <input type="number" class="form-control" id="daily_salary" name="daily_salary" data-dynamic-input="true">
      </div>
      <div class="form-group" data-dynamic-field="true">
      <label for="worked_days_year_label">Días trabajados en el año</label>
      <input type="number" class="form-control" id="worked_days_year" name="worked_days_year" data-dynamic-input="true">
      </div>'
      @customPartial = "survey/custom_mexico"
      @fakeRenderer = Object.new
      def @fakeRenderer.render(**opts)
        @received_opts = opts
        "<div>Fake render</div>"
      end
    end

    def test_initialize_uses_the_default_base_view_file_path
      view = ViewMexico.new
      assert_equal "survey/mexico_gratification",
                   view.instance_variable_get(:@baseViewFilePath)
    end

    def test_initialize_accepts_a_custom_base_view_file_path
      view = ViewMexico.new(baseViewFilePath: @customPartial)
      assert_equal @customPartial,
                   view.instance_variable_get(:@baseViewFilePath)
    end

    def test_get_view_calls_renderer_with_custom_view_and_returns_its_result
      view = ViewMexico.new(baseViewFilePath: @customPartial)

      ApplicationController.stub(:renderer, @fakeRenderer) do
        html = view.getView
        assert_equal "<div>Fake render</div>", html

        received = @fakeRenderer.instance_variable_get(:@received_opts)
        assert_equal({ partial: @customPartial }, received)
      end
    end
  end

  def test_get_view_calls_renderer_with_real_view_and_returns_its_result
      view = ViewMexico.new
      html = view.getView
      assert_equal @realHtmlExpected.squish, html.squish
  end
end
