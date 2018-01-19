require 'byebug'
class PolyTreeNode
  attr_reader :children, :value, :parent
  
  def initialize (value)
    @value = value
    @parent = nil 
    @children = []
  end

  def parent=(node)
    if parent != nil
      parent.children.delete(self)
    end
    @parent = node
    parent.children.push(self) unless parent == nil || parent.children.include?(self)
  end
  
  def add_child(child_node)
    children.push(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    if self.children.include?(child_node)
      children.delete(child_node)
      child_node.parent = nil
    else
      raise "Node does not have this child."
    end
  end
  
  def dfs(target_value)
    return self if target_value == self.value
    
    self.children.each do |child|
      stored = child.dfs(target_value)
      return stored unless stored.nil?
    end
    
    nil
  end
  
  def bfs(target_value)
    queue = [self]
    
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each do |child|
        queue << child
      end
    end
    nil
  end
end