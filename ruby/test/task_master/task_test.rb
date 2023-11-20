require_relative "../test_helper"

class TaskMaster::TaskTest < Minitest::Test
  def setup
    @class_name = TaskMaster::Task
  end

  def test_should_return_id_of_task
    expected = 1
    actual = @class_name.new(
      id: expected.to_s,
      name: "Chore",
      assignee: "John Smith",
      due_on: "2023-10-31",
      status: "In Progress"
    ).id
    assert_equal(expected, actual)
  end

  def test_should_return_name_of_task
    expected = "Chore"
    actual = @class_name.new(
      id: "1",
      name: expected,
      assignee: "John Smith",
      due_on: "2023-10-31",
      status: "In Progress"
    ).name
    assert_equal(expected, actual)
  end

  def test_should_return_assignee_of_task
    expected = "John Smith"
    actual = @class_name.new(
      id: "1",
      name: "Chore",
      assignee: expected,
      due_on: "2023-10-31",
      status: "In Progress"
    ).assignee
    assert_equal(expected, actual)
  end

  def test_should_return_due_on_of_task
    expected = Date.parse("2023-10-31")
    actual = @class_name.new(
      id: "1",
      name: "Chore",
      assignee: "John Smith",
      due_on: expected.to_s,
      status: "In Progress"
    ).due_on
    assert_equal(expected, actual)
  end

  def test_should_return_status_of_task
    expected = "In Progress"
    actual = @class_name.new(
      id: "1",
      name: "Chore",
      assignee: "John Smith",
      due_on: "2023-10-31",
      status: expected
    ).status
    assert_equal(expected, actual)
  end

  def test_should_return_true_if_the_task_has_a_status_that_matches_a_given_list_of_statuses
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Completed"
      ).status_of?(["Completed"])
    )
  end

  def test_should_return_false_if_the_task_has_a_status_that_differs_a_given_list_of_statuses
    refute(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Completed"
      ).status_of?(["In Progress"])
    )
  end

  def test_should_return_true_if_the_task_has_a_assignee_that_matches_a_given_list_of_assignees
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Completed"
      ).assigned_to?(["John Smith"])
    )
  end

  def test_should_return_false_if_the_task_has_a_assignee_that_differs_a_given_list_of_assignees
    refute(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Completed"
      ).assigned_to?(["Jane Doe"])
    )
  end

  def test_should_return_true_if_the_task_is_complete
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Completed"
      ).complete?
    )
  end

  def test_should_return_false_if_the_task_is_incomplete
    refute(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "In Progress"
      ).complete?
    )
  end

  def test_should_return_true_if_the_task_is_in_progress
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "In Progress"
      ).in_progress?
    )
  end

  def test_should_return_false_if_the_task_is_not_in_progress
    refute(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Not Started"
      ).in_progress?
    )
  end

  def test_should_return_true_if_the_task_is_not_started
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "Not Started"
      ).not_started?
    )
  end

  def test_should_return_false_if_the_task_has_been_started
    refute(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: "2023-10-31",
        status: "In Progress"
      ).not_started?
    )
  end

  def test_should_return_true_if_the_task_has_a_due_date_within_the_upcoming_week
    in_next_seven_days = Date.today + 7
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: in_next_seven_days.to_s,
        status: "Completed"
      ).upcoming?
    )
  end

  def test_should_return_false_if_the_task_has_a_due_date_that_is_not_within_the_upcoming_week
    in_next_eight_days = Date.today + 8
    refute(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: in_next_eight_days.to_s,
        status: "Completed"
      ).upcoming?
    )
  end

  def test_should_return_true_if_the_task_has_a_due_date_that_is_past_due
    yesterday = Date.today - 1
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: yesterday.to_s,
        status: "In Progress"
      ).overdue?
    )
  end

  def test_should_return_the_number_of_days_until_due_date_as_integer
    expected = 7
    next_week = Date.today + expected
    assert_equal(
      expected,
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: next_week.to_s,
        status: "Completed"
      ).number_of_days_until_due
    )
  end

  def test_should_return_the_number_of_days_until_due_date_should_positive_if_due_on_in_future
    next_week = Date.today + 7
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: next_week.to_s,
        status: "Completed"
      ).number_of_days_until_due.positive?
    )
  end

  def test_should_return_the_number_of_days_until_due_date_should_negative_if_due_on_in_past
    last_week = Date.today - 7
    assert(
      @class_name.new(
        id: "1",
        name: "Chore",
        assignee: "John Smith",
        due_on: last_week.to_s,
        status: "Completed"
      ).number_of_days_until_due.negative?
    )
  end
end
