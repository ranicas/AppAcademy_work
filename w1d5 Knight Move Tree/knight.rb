require './trees'

class KnightPathFinder
  attr_reader :visited_positions

  VECTORS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]

  def initialize(pos)
    @visited_positions = [pos]
    @root_node = PolyTreeNode.new(pos)
    build_move_tree
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)

    end_node.trace_path_back(@root_node)
  end

  def build_move_tree

    queue = [@root_node]

    until queue.empty?
      cur_node = queue.shift
      new_move_positions(cur_node.value).each do |pos|
        new_node = PolyTreeNode.new(pos)
        queue << new_node
        cur_node.add_child(new_node)
        @visited_positions << new_node.value
      end
    end
  end

  def self.valid_moves(pos)
    moves = VECTORS.map do |vector|
      [pos[0] + vector[0], pos[1] + vector[1]]
    end

    moves.select do |array|
      array[0] >= 0 && array[1] >= 0 && array[0] < 8 && array[1] < 8
    end
  end

  def new_move_positions(pos)
    self.class.valid_moves(pos).select do |arr|
      !@visited_positions.include?(arr)
    end
  end

end

kp = KnightPathFinder.new([0,0])

p kp.new_move_positions([0, 0])

p kp.find_path([7,6])
