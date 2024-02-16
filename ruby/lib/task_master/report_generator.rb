module TaskMaster
  class ReportGenerator
    def initialize(repository_adapter, output_handler)
      @repository_adapter = repository_adapter
      @output_handler = output_handler
    end

    def task_list_report(sort_by: "Task ID", order: :desc)
      report.generate(repository.list(sort_by: sort_by, order: order))
    end

    def overdue_tasks_report(sort_by: "Task ID", order: :desc)
      report.generate(repository.list_overdue(sort_by: sort_by, order: order))
    end

    def tasks_by_status_report(statuses, sort_by: "Task ID", order: :desc)
      report.generate(repository.list_by_status(statuses, sort_by: sort_by, order: order))
    end

    def tasks_by_assignee_report(assignees, sort_by: "Task ID", order: :desc)
      report.generate(repository.list_by_assignee(assignees, sort_by: sort_by, order: order))
    end

    def upcoming_tasks_report(sort_by: "Task ID", order: :desc)
      report.generate(repository.list_upcoming(sort_by: sort_by, order: order))
    end

    def completed_tasks_report(sort_by: "Task ID", order: :desc)
      report.generate(repository.list_completed(sort_by: sort_by, order: order))
    end

    def task_summary_report
      report.generate(repository.list)
    end

    def task_distribution_report
      report.generate(repository.list)
    end

    def countdown_report(sort_by: "Task ID", order: :desc)
      report.generate(repository.list(sort_by: sort_by, order: order))
    end

    private

    def repository
      TaskMaster::TaskRepository.new(@repository_adapter)
    end

    def report
      TaskMaster::Report.new(@output_handler)
    end
  end
end
