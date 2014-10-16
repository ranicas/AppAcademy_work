#assume square matrix
def my_transpose(rows)
  dimension = rows.first.count
  columns = Array.new(dimension) { Array.new(dimension) }
  matrix.length.times do |i|
    matrix_transpose[i]=[]
    matrix[0].length.times do |j|
       matrix_transpose[i][j]=matrix[j][i] 
    end
  end
  matrix_transpose
end

p my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])
