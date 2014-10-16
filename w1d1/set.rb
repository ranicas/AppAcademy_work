class MyHashSet
  def initialize
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store[el].nil? ? false : true   
  end
  
  def delete(el)
    if @store.include?(el) 
      @store.delete(el)
      return true
    else
      return false
    end
  end
  
  def union(set2)
    @store.merge(set2)
  end
  
  def intersect(set2)
    intersection = {}
    @store.each do |key, value|
      intersection[key] = value if set2.has_key?(key) 
    end
    intersection
  end
  
  def minus(set2)
    minus = {}
    @store.each do |key, value|
      minus[key] = value if !set2.has_key?(key) 
    end
    minus
  end
end

set1 = MyHashSet.new
set2 = {"a" => 1, "b" => 2, "c" => 3}

set1.insert("x")
set1.insert("a")
puts set1.include?("a")
puts set1.intersect(set2)
puts set1.union(set2)
puts set1.minus(set2)