class PolyTreeNode
  attr_reader :value
  attr_accessor :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    unless self.parent.nil?
      self.parent.children.delete(self)
    end
    @parent = new_parent

    unless new_parent.nil?
      new_parent.children << self
    end
  end

  def add_child(new_child)
    self.children << new_child
    new_child.parent = self
  end

  def remove_child(old_child)
    if old_child.parent.nil?
      raise "Not a child!!!"
    end

    self.children.delete(old_child)
    old_child.parent = nil
  end

  def dfs(val)
    return self if self.value == val

    self.children.each do |child|
      result = child.dfs(val)
      return result unless result.nil?
    end

    nil
  end

  def bfs(val)
    return self if self.value == val
    search_ary = self.children

    search_ary.each do |child|
      return child if child.value == val
      child.children.each do |grandchild|
        search_ary << grandchild
      end
    end

    nil
  end

  def trace_path_back(ancestor)
    return [self.value] if self.value == ancestor.value

    trace_arr = self.parent.trace_path_back(ancestor)
    trace_arr << self.value
  end
end






