require "test_helper"

module ViewClasses
  class ViewChileTest < ActiveSupport::TestCase
    def setup
      @realHtmlExpected = '<div class="form-group" data-dynamic-field="true">
      <label for="base_salary_label">Sueldo base mensual</label>
      <input type="number" class="form-control" id="monthly_base_salary" name="monthly_base_salary" data-dynamic-input="true">
      </div>
      <div class="form-group" data-dynamic-field="true">
      <label for="minimum_income_label">Ingreso mínimo mensual</label>
      <input type="number" class="form-control" id="minimum_monthly_income" name="minimum_monthly_income" data-dynamic-input="true">
      </div>'
      @customPartial = "survey/custom_chile"
      @fakeRenderer = Object.new
      def @fakeRenderer.render(**opts)
        @received_opts = opts
        "<div>Fake render</div>"
      end
    end

    def test_initialize_uses_the_default_base_view_file_path
      view = ViewChile.new
      assert_equal "survey/chile_gratification",
                   view.instance_variable_get(:@baseViewFilePath)
    end

    def test_initialize_accepts_a_custom_base_view_file_path
      view = ViewChile.new(baseViewFilePath: @customPartial)
      assert_equal @customPartial,
                   view.instance_variable_get(:@baseViewFilePath)
    end

    def test_get_view_calls_renderer_with_custom_view_and_returns_its_result
      view = ViewChile.new(baseViewFilePath: @customPartial)

      ApplicationController.stub(:renderer, @fakeRenderer) do
        html = view.getView
        assert_equal "<div>Fake render</div>", html

        received = @fakeRenderer.instance_variable_get(:@received_opts)
        assert_equal({ partial: @customPartial }, received)
      end
    end
  end

  def test_get_view_calls_renderer_with_real_view_and_returns_its_result
      view = ViewChile.new
      html = view.getView
      assert_equal @realHtmlExpected.squish, html.squish
  end
end
