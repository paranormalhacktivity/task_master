module TaskMaster
  module OutputHandlers
    module CountdownReport
      class TerminalHandler
        def generate_output(data)
          AsciiTable.new(headers, DataProcessor.new(data).process).draw
        end

        private

        def headers
          ["Task ID", "Task Name", "Assignee", "Due Date", "Status", "Time Remaining (Days)"]
        end

        class DataProcessor
          def initialize(data)
            @data = data
          end

          def process
            @data.map do |task|
              [
                task.id.to_s,
                task.name,
                task.assignee,
                task.due_on.to_s,
                task.status,
                time_until_due_string(task)
              ]
            end
          end

          private

          def time_until_due_string(task)
            if task.number_of_days_until_due.abs == 1
              task.overdue? ? "1 day overdue" : "1 day"
            elsif task.complete?
              "-"
            else
              "#{task.number_of_days_until_due.abs} days#{' overdue' if task.overdue?}"
            end
          end
        end
      end
    end
  end
end
