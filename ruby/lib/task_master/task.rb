module TaskMaster
  class Task
    attr_reader :id, :name, :assignee, :due_on, :status

    def initialize(id:, name:, assignee:, due_on:, status:)
      @id = id.to_i
      @name = name.to_s
      @assignee = assignee.to_s
      @due_on = Date.parse(due_on)
      @status = status.to_s
    end

    def incomplete?
      !complete?
    end

    def complete?
      status_of?("Completed")
    end

    def in_progress?
      status_of?("In Progress")
    end

    def not_started?
      status_of?("Not Started")
    end

    def status_of?(statuses)
      statuses.include?(status)
    end

    def assigned_to?(assignees)
      assignees.include?(assignee)
    end

    def upcoming?
      @due_on.between?(Date.today, next_week)
    end

    def overdue?
      @due_on < Date.today && incomplete?
    end

    def number_of_days_until_due
      (@due_on - Date.today).to_i
    end

    private

    def next_week
      Date.today + 7
    end
  end
end
