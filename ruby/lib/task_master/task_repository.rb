module TaskMaster
  class TaskRepository
    def initialize(adapter)
      @adapter = adapter
    end

    def list(sort_by: "Task ID", order: :desc)
      @list ||= @adapter.list.map { |task_data| Task.new(**task_data) }
    end

    def list_by_status(status, sort_by: "Task ID", order: :desc)
      list.select { |task| task.status_of?(status) }
    end

    def list_by_assignee(assignee, sort_by: "Task ID", order: :desc)
      list.select { |task| task.assigned_to?(assignee) }
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

