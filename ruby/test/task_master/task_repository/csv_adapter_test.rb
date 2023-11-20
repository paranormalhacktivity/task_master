require_relative "../../test_helper"

class TaskMaster::TaskRepository::CsvAdapterTest < Minitest::Test
  def setup
    @fixture_file = File.join(__dir__, "../..", "fixtures/test_data.csv")
    @class_name = TaskMaster::TaskRepository::CsvAdapter
  end

  def test_should_list_all_task_in_supplied_csv
    expected = 6
    assert_equal(expected, @class_name.new(@fixture_file).list.count)
  end
end
