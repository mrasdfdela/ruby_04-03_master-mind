require 'byebug'

class Mastermind
  # variables
    # available colors
    attr_reader :game_over, :num_colors, :board

  # start game
    # initialize maker - select color pattern
    # create color counter
    def initialize(board_size, num_colors=6)
      @game_over = false
      @board = Board.new(board_size)
    end

    def play
      @board.print_board
    end
end

class Hole
  attr_accessor :color
  def initialize(color=nil)
    @color = color
  end
end

class Code

end

class Maker
  
end

class Guesser
  
end

class Board
  attr_accessor :board
  # print complete board, guesses, and correct placements/correct colors
  # location of 
  def initialize(guesses)
    @board = Array.new(guesses) {
      Array.new(4) {
        Hole.new()
      }
    }
  end

  def print_board
    puts "Current Mastermind Board"
    board.each_with_index do |row, idx|
      i = (idx + 1).to_s
      i = " #{i}" if i.length < 2
      row_print = "#{i} "

      row.each do |hole|
        # byebug
        hole.color == nil ? row_print += " X" : row_print += " #{hole.color[0]}"
      end
      puts row_print

    end
  end
end

new_game = Mastermind.new(12)
new_game.play