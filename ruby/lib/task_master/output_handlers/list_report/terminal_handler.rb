module TaskMaster
  module OutputHandlers
    module ListReport
      class TerminalHandler
        def generate_output(data)
          AsciiTable.new(headers, DataProcessor.new(data).process).draw
        end

        private

        def headers
          ["Task ID", "Task Name", "Assignee", "Due Date", "Status"]
        end

        class DataProcessor
          def initialize(data)
            @data = data
          end

          def process
            @data.map do |d|
              [d.id.to_s, d.name, d.assignee, d.due_on.to_s, d.status]
            end
          end
        end
      end
    end
  end
end

