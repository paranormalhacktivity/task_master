require_relative "../test_helper"

class TaskMaster::ReportTest < Minitest::Test
  def setup
    @class_name = TaskMaster::Report
  end

  def test_should_generate_a_report_by_passing_data_to_the_output_handler_to_generate_output
    test_data = "This is a test"
    expected = test_data + " that it made it to the handler"
    assert_equal(
      expected,
      @class_name.new(TestHandler.new).generate_report(test_data)
    )
  end

  class TestHandler
    def generate_output(data)
      data + " that it made it to the handler"
    end
  end
end
