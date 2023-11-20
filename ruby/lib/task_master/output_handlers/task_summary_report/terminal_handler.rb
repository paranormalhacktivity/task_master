module TaskMaster
  module OutputHandlers
    module TaskSummaryReport
      class TerminalHandler
        def generate_output(data)
          AsciiTable.new(headers, DataProcessor.new(data).process).draw
        end

        private

        def headers
          ["Metric", "Count"]
        end

        class DataProcessor
          def initialize(data)
            @data = data
          end

          def process
            [
              ["Total Tasks", @data.count.to_s],
              ["Completed Tasks", @data.count(&:complete?).to_s],
              ["Tasks in Progress", @data.count(&:in_progress?).to_s],
              ["Tasks Not Started", @data.count(&:not_started?).to_s]
            ]
          end
        end
      end
    end
  end
end
