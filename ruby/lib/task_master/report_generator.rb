module TaskMaster
  class ReportGenerator
    def initialize(repository_adapter, output_handler)
      @repository_adapter = repository_adapter
      @output_handler = output_handler
    end

    def task_list_report(sort_by: "Task ID", order: :desc)
      list_report.generate_report(repository.list(sort_by: sort_by, order: order))
    end

    def overdue_tasks_report(sort_by: "Task ID", order: :desc)
      list_report.generate_report(repository.list_overdue(sort_by: sort_by, order: order))
    end

    def tasks_by_status_report(status, sort_by: "Task ID", order: :desc)
      list_report.generate_report(repository.list_by_status(status, sort_by: sort_by, order: order))
    end

    def tasks_by_assignee_report(assignee, sort_by: "Task ID", order: :desc)
      list_report.generate_report(repository.list_by_assignee(assignee, sort_by: sort_by, order: order))
    end

    def upcoming_tasks_report(sort_by: "Task ID", order: :desc)
      list_report.generate_report(repository.list_upcoming(sort_by: sort_by, order: order))
    end

    def completed_tasks_report(sort_by: "Task ID", order: :desc)
      list_report.generate_report(repository.list_completed(sort_by: sort_by, order: order))
    end

    def task_summary_report
      TaskMaster::Report.new(@output_handler).generate_report(repository.list)
    end

    def task_distribution_report
      TaskMaster::Report.new(@output_handler).generate_report(repository.list)
    end

    def countdown_report(sort_by: "Task ID", order: :desc)
      TaskMaster::Report.new(@output_handler).generate_report(repository.list(sort_by: sort_by, order: order))
    end

    private

    def repository
      TaskMaster::TaskRepository.new(@repository_adapter)
    end

    def list_report
      TaskMaster::Report.new(@output_handler)
    end
  end
end
