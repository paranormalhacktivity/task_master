module TaskMaster
  class TaskRepository
    def initialize(adapter)
      @adapter = adapter
    end

    def list(sort_by: "Task ID", order: :desc)
      @list ||= @adapter.list.map { |task_data| Task.new(**task_data) }
    end

    def list_by_status(statuses, sort_by: "Task ID", order: :desc)
      list.select { |task| task.status_of?(statuses) }
    end

    def list_by_assignee(assignees, sort_by: "Task ID", order: :desc)
      list.select { |task| task.assigned_to?(assignees) }
    end

    def list_upcoming(sort_by: "Task ID", order: :desc)
      list.select { |task| task.upcoming? }
    end

    def list_overdue(sort_by: "Task ID", order: :desc)
      list.select { |task| task.overdue? }
    end

    def list_completed(sort_by: "Task ID", order: :desc)
      list.select { |task| task.complete? }
    end
  end
end

