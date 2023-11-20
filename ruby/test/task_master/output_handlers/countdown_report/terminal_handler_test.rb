require_relative "../../../test_helper"

class TaskMaster::OutputHandlers::CountdownReport::TerminalHandlerTest < Minitest::Test
  def setup
    @class_name = TaskMaster::OutputHandlers::CountdownReport::TerminalHandler
  end

  def test_should_call_ascii_table_and_draw_with_correct_headers
    test_data = [OpenStruct.new(id: 1), OpenStruct.new(id: 2)]
    expected = ["Task ID", "Task Name", "Assignee", "Due Date", "Status", "Time Remaining (Days)"]
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

  class TaskMaster::OutputHandlers::CountdownReport::TerminalHandler::DataProcessorTest < Minitest::Test
    def setup
      @class_name = TaskMaster::OutputHandlers::CountdownReport::TerminalHandler::DataProcessor
    end

    def test_should_return_array_with_id_name_assignee_due_on_and_status
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
          assignee: "Jim Bob",
          due_on: "2023-11-11",
          status: "In Progress"
        ),
        TaskMaster::Task.new(
          id: "4",
          name: "Quux",
          assignee: "Jim Bob",
          due_on: "2023-11-12",
          status: "In Progress"
        )
      ]
      expected = [
        ["1", "Foo", "Jim Bob", "2023-11-08", "Completed", "-"],
        ["2", "Bar", "Jim Bob", "2023-11-09", "In Progress", "1 day overdue"],
        ["3", "Baz", "Jim Bob", "2023-11-11", "In Progress", "1 day"],
        ["4", "Quux", "Jim Bob", "2023-11-12", "In Progress", "2 days"],
      ]
      Date.stub :today, Date.parse("2023-11-10") do
        assert_equal(expected, @class_name.new(test_data).process)
      end
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
