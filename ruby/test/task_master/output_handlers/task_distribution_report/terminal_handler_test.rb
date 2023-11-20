require_relative "../../../test_helper"

class TaskMaster::OutputHandlers::TaskDistributionReport::TerminalHandlerTest < Minitest::Test
  def setup
    @class_name = TaskMaster::OutputHandlers::TaskDistributionReport::TerminalHandler
  end

  def test_should_call_ascii_table_and_draw_with_correct_headers
    test_data = [OpenStruct.new(id: 1), OpenStruct.new(id: 2)]
    expected = ["Assignee", "Count"]
    TaskMaster::AsciiTable.stub :new, ->(a, b) { TestAsciiTable.new(a, b) } do
      @class_name::DataProcessor.stub :new, -> (a) { TestDataProcessor.new(a) } do
        assert_equal(
          expected,
          @class_name.new.generate_output(test_data)[:headers]
        )
      end
    end
  end

  def test_should_call_ascii_table_and_draw_with_correct_row_data_that_came_from_the_data_processor
    test_data = [OpenStruct.new(id: 1), OpenStruct.new(id: 2)]
    expected = test_data.map(&:id)
    TaskMaster::AsciiTable.stub :new, ->(a, b) { TestAsciiTable.new(a, b) } do
      @class_name::DataProcessor.stub :new, -> (a) { TestDataProcessor.new(a) } do
        assert_equal(
          expected,
          @class_name.new.generate_output(test_data)[:rows]
        )
      end
    end
  end

  class TaskMaster::OutputHandlers::TaskDistributionReport::TerminalHandler::DataProcessorTest < Minitest::Test
    def setup
      @class_name = TaskMaster::OutputHandlers::TaskDistributionReport::TerminalHandler::DataProcessor
    end

    def test_should_return_array_with_assignee_name_and_count_of_task_they_are_assigned_to
      test_data = [
        TaskMaster::Task.new(
          id: "1",
          name: "Foo",
          assignee: "Jim Bob",
          due_on: "2023-11-08",
          status: "Completed"
        ),
        TaskMaster::Task.new(
          id: "2",
          name: "Bar",
          assignee: "Jim Bob",
          due_on: "2023-11-09",
          status: "In Progress"
        ),
        TaskMaster::Task.new(
          id: "3",
          name: "Baz",
          assignee: "John Smith",
          due_on: "2023-11-11",
          status: "In Progress"
        )
      ]
      expected = [
        ["Jim Bob", "2"],
        ["John Smith", "1"]
      ]
      assert_equal(expected, @class_name.new(test_data).process)
    end
  end

  class TestAsciiTable
    def initialize(headers, rows)
      @headers = headers
      @rows = rows
    end

    def draw
      {
        headers: @headers,
        rows: @rows
      }
    end
  end

  class TestDataProcessor
    def initialize(data)
      @data = data
    end

    def process
      @data.map(&:id)
    end
  end
end
