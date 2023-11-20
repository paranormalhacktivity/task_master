require_relative "../test_helper"

class TaskMaster::TaskRepositoryTest < Minitest::Test
  def setup
    @mock_adapter = TestAdapter.new
    @class_name = TaskMaster::TaskRepository
  end

  def test_should_delegate_to_the_list_function_of_the_supplied_adapter
    expected = @mock_adapter.list.map { |x| x[:name] }
    assert_equal(expected, @class_name.new(@mock_adapter).list.map(&:name))
  end

  def test_should_filter_list_of_tasks_by_status
    expected = ["Foo"]
    assert_equal(expected, @class_name.new(@mock_adapter).list_by_status("Completed").map(&:name))
  end

  def test_should_filter_list_of_tasks_by_assignee
    expected = ["Baz"]
    assert_equal(expected, @class_name.new(@mock_adapter).list_by_assignee("John Smith").map(&:name))
  end

  def test_should_list_tasks_that_are_within_the_week_as_upcoming
    expected = ["Baz"]
    Date.stub :today, Date.parse("2023-11-12") do
      assert_equal(expected, @class_name.new(@mock_adapter).list_upcoming.map(&:name))
    end
  end

  def test_should_not_list_tasks_that_are_not_within_the_week_as_upcoming
    Date.stub :today, Date.parse("2023-11-12") do
      refute_includes(
        @class_name.new(@mock_adapter).list_upcoming.map(&:name),
        "Quux"
      )
    end
  end

  def test_should_list_tasks_as_overdue_if_they_happen_in_the_past_and_have_not_been_completed
    expected = ["Bar"]
    Date.stub :today, Date.parse("2023-11-12") do
      assert_equal(
        expected,
        @class_name.new(@mock_adapter).list_overdue.map(&:name)
      )
    end
  end

  def test_should_filter_list_of_tasks_by_ones_that_have_been_completed
    expected = ["Foo"]
    assert_equal(expected, @class_name.new(@mock_adapter).list_completed.map(&:name))
  end

  class TestAdapter
    def list
      [
        {
          id: "1",
          name: "Foo",
          assignee: "Jim Bob",
          due_on: "2023-11-11",
          status: "Completed"
        },
        {
          id: "2",
          name: "Bar",
          assignee: "Jim Bob",
          due_on: "2023-11-11",
          status: "In Progress"
        },
        {
          id: "3",
          name: "Baz",
          assignee: "John Smith",
          due_on: "2023-11-13",
          status: "Not Started"
        },
        {
          id: "4",
          name: "Quux",
          assignee: "Jane Doe",
          due_on: "2023-11-23",
          status: "Not Started"
        }
      ]
    end
  end
end
