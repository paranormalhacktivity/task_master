module TaskMaster
  class AsciiTable
    def initialize(headers, rows)
      @headers = headers
      @rows = rows
      @column_widths = calculate_column_widths
    end

    def draw
      puts horizontal_line
      print_row(@headers)
      puts horizontal_line
      @rows.each { |row| print_row(row) }
      puts horizontal_line
    end

    private

    def calculate_column_widths
      @headers.map.with_index do |header, i|
        [header, *@rows.map { |row| row[i] }].max_by(&:length).length + 2
      end
    end

    def horizontal_line
      '+' + @column_widths.map { |width| '-' * width }.join('+') + '+'
    end

    def print_row(row)
      row.each_with_index do |cell, i|
        print "| #{cell.ljust(@column_widths[i] - 2)} "
      end
      puts '|'
    end
  end
end
