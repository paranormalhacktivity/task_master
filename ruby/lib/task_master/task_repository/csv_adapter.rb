module TaskMaster
  class TaskRepository
    class CsvAdapter
      def initialize(csv_file_path)
        @csv_file_path = csv_file_path
      end

      def list
        CSV.foreach(@csv_file_path, headers: true).map do |row|
          task_data(row)
        end
      end

      private

      def task_data(row)
        {
          id: row["Task ID"],
          name: row["Task Name"],
          assignee: row["Assignee"],
          due_on: row["Due Date"],
          status: row["Status"]
        }
      end
    end
  end
end
