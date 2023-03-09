# frozen_string_literal: true

def row_column
  files = Dir.glob('*')
  column = 3
  rest_of_row_count = files.size % column
  if rest_of_row_count != 0 && rest_of_row_count.positive?
    (column - rest_of_row_count).times do
      files << nil
    end
  end
  row_count = files.size / column
  files.each_slice(row_count).to_a
end

def display(column_row)
  column_row.each do |files_line|
    files_line.each do |line|
      print line.to_s.ljust(10)
    end
    puts "\n"
  end
end
display(row_column.transpose)
