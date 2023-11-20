module TaskMaster
  module OutputHandlers
    module TaskDistributionReport
      class TerminalHandler
        def generate_output(data)
          AsciiTable.new(headers, DataProcessor.new(data).process).draw
        end

        private

        def headers
          ["Assignee", "Count"]
        end

        class DataProcessor
          def initialize(data)
            @data = data
          end

          def process
            @data.map(&:assignee).uniq.sort.map do |assignee_name|
              [assignee_name, @data.count { |x| x.assigned_to?(assignee_name) }.to_s]
            end
          end
        end
      end
    end
  end
end
