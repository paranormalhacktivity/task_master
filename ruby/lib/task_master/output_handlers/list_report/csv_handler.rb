module TaskMaster
  module OutputHandlers
    module ListReport
      class CsvHandler
        def generate_output(data)
          CSV.open(file_path, 'w', write_headers: true, headers: headers) do |csv|
            data.each do |row|
              csv << row
            end
          end
        end

        private

        def headers
          ["Task ID", "Task Name", "Assignee", "Due Date", "Status"]
        end
      end
    end
  end
end
