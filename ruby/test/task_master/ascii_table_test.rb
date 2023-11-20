require_relative "../test_helper"

class TaskMaster::AsciiTableTest < Minitest::Test
  def setup
    @headers = ["Header 1", "Header 2"]
    @rows = [["foo", "1"], ["bar", "12"]]
    @class_name = TaskMaster::AsciiTable
  end

  def test_should_write_table_to_stdout
    output = capture_io do
      @class_name.new(@headers, @rows).draw
    end
    assert_equal(expected_table, output.join)
  end

  def test_should_return_table_where_each_line_of_the_table_has_same_number_characters
    output = capture_io do
      @class_name.new(@headers, @rows).draw
    end
    assert(
      output.join.split("\n").map(&:length).uniq.length == 1
    )
  end

  def test_should_dynamically_resize_table_based_on_cell_contents_size
    different_sized_headers = ["Extra long header 1", "Extra long header 2"]
    output_one = capture_io do
      @class_name.new(@headers, @rows).draw
    end
    output_two = capture_io do
      @class_name.new(different_sized_headers, @rows).draw
    end

    refute_equal(
      output_one.join.split("\n").map(&:length).uniq.first,
      output_two.join.split("\n").map(&:length).uniq.first
    )
  end

  def expected_table
    [
      "+----------+----------+\n",
      "| Header 1 | Header 2 |\n",
      "+----------+----------+\n",
      "| foo      | 1        |\n",
      "| bar      | 12       |\n",
      "+----------+----------+\n"
    ].join
  end
end
