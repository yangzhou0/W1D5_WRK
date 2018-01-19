require_relative 'polytree_node.rb'
require 'byebug'
class KnightPathFinder
  attr_reader :visited_positions, :origin
  
  def initialize(start_pos)
    @visited_positions = [start_pos]
    @origin = start_pos
  end
  

  
  def self.valid_moves(pos)
    valid_moves = all_possible_moves(pos)
    valid_moves.select {|move| on_board?(move)}
    
  end
  
  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos) - visited_positions
    @visited_positions += new_moves
    new_moves
  end
  
  def self.all_possible_moves(pos)
    moves=[]
    x,y=pos
    moves <<[x+2, y+1]
    moves <<[x+2, y-1]
    
    moves <<[x+1, y+2]
    moves <<[x+1, y-2]
    
    moves <<[x-1, y+2]
    moves <<[x-1, y-2]
    
    moves <<[x-2, y+1]
    moves <<[x-2, y-1]
  end
  
  def self.on_board?(pos)
    (0..7).include?(pos.first) && (0..7).include?(pos.last)
  end
  
  def build_move_tree
    root = PolyTreeNode.new(origin)
    queue = [root]
    
    until queue.empty?
      parent = queue.shift
      pos = parent.value
      
      new_moves = new_move_positions(pos)
      
      new_moves.each do |move|
        child = PolyTreeNode.new(move)
        parent.add_child(child)
        queue << child
      end
    end
    root
  end
  
  # def find_path(target)
  #   tree = build_move_tree
  # 
  # end
end


