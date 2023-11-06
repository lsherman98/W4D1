require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)#
    if board.over? 
      return board.won? && board.winner != evaluator   
    end

    if evaluator == next_mover_mark
      self.children.all? { |child| child.losing_node?(evaluator)}
    else
      self.children.any? { |child| child.losing_node?(evaluator)}
    end
      
  end

  def winning_node?(evaluator)
    # if board.over? && board.winner.nil?
    #   return false
    # elsif board.over? && board.winner == next_mover_mark


  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    possible_boards = []
    board.rows.each.with_index do |row, row_idx|
      row.each_index do |col_idx|
        if row[col_idx].nil?
          dup_board = board.dup
          dup_board[[row_idx, col_idx]] = next_mover_mark
          possible_boards << TicTacToeNode.new(dup_board, dup_board.next_mark, [row_idx, col_idx])
        end
      end
    end
    possible_boards
  end

 
end
