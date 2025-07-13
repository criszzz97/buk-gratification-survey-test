require "test_helper"

module ViewClasses
  class ViewColombiaTest < ActiveSupport::TestCase
    def setup
      @realHtmlExpected = '<div class="form-group" data-dynamic-field="true">
      <label for="monthly_salary_label">Salario mensual</label>
      <input type="number" class="form-control" id="monthly_salary" name="monthly_salary" data-dynamic-input="true">
      </div>
      <div class="form-group" data-dynamic-field="true">
      <label for="worked_days_semester_label">Días trabajados en el semestre</label>
      <input type="number" class="form-control" id="worked_days_semester" name="worked_days_semester" data-dynamic-input="true">
      </div>'
      @customPartial = "survey/custom_colombia"
      @fakeRenderer = Object.new
      def @fakeRenderer.render(**opts)
        @received_opts = opts
        "<div>Fake render</div>"
      end
    end

    def test_initialize_uses_the_default_base_view_file_path
      view = ViewColombia.new
      assert_equal "survey/colombia_gratification",
                   view.instance_variable_get(:@baseViewFilePath)
    end

    def test_initialize_accepts_a_custom_base_view_file_path
      view = ViewColombia.new(baseViewFilePath: @customPartial)
      assert_equal @customPartial,
                   view.instance_variable_get(:@baseViewFilePath)
    end

    def test_get_view_calls_renderer_with_custom_view_and_returns_its_result
      view = ViewColombia.new(baseViewFilePath: @customPartial)

      ApplicationController.stub(:renderer, @fakeRenderer) do
        html = view.getView
        assert_equal "<div>Fake render</div>", html

        received = @fakeRenderer.instance_variable_get(:@received_opts)
        assert_equal({ partial: @customPartial }, received)
      end
    end
  end

  def test_get_view_calls_renderer_with_real_view_and_returns_its_result
      view = ViewColombia.new
      html = view.getView
      assert_equal @realHtmlExpected.squish, html.squish
  end
end
