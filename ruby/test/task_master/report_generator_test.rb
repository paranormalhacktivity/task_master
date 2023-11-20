require_relative "../test_helper"

class TaskMaster::ReportGeneratorTest < Minitest::Test
  def setup
    @mock_repository = TestRepository.new
    @mock_handler = TestHandler.new
    @class_name = TaskMaster::ReportGenerator
  end

  def test_list_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list, generator.task_list_report)
    end
  end

  def test_tasks_by_status_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list_by_status("Test"), generator.tasks_by_status_report("Test"))
    end
  end

  def test_tasks_by_assignee_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list_by_assignee("Test"), generator.tasks_by_assignee_report("Test"))
    end
  end

  def test_upcoming_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list_upcoming, generator.upcoming_tasks_report)
    end
  end

  def test_overdue_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list_overdue, generator.overdue_tasks_report)
    end
  end

  def test_completed_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list_completed, generator.completed_tasks_report)
    end
  end

  def test_summary_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list, generator.task_summary_report)
    end
  end

  def test_distribution_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list, generator.task_distribution_report)
    end
  end

  def test_countdown_report
    generator = @class_name.new(
      "Should be a repo adapter, but doesn't matter because we're stubbing repo",
      @mock_handler
    )
    TaskMaster::TaskRepository.stub :new, @mock_repository do
      assert_equal(@mock_repository.list, generator.countdown_report)
    end
  end

  class TestRepository
    def list(sort_by: nil, order: nil)
      ["list success"]
    end

    def list_overdue(sort_by: nil, order: nil)
      ["list overdue"]
    end

    def list_by_status(status, sort_by: nil, order: nil)
      ["list by #{status}"]
    end

    def list_by_assignee(assignee, sort_by: nil, order: nil)
      ["list by #{assignee}"]
    end

    def list_upcoming(sort_by: nil, order: nil)
      ["list upcoming"]
    end

    def list_completed(sort_by: nil, order: nil)
      ["list Completed"]
    end
  end

  class TestHandler
    def generate_output(data)
      data
    end
  end
end
