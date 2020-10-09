require 'byebug'

class Mastermind
  # variables
    # available colors
    attr_reader :game_over, :num_colors, :board, :code

  # start game
    # initialize maker - select color pattern
    # create color counter
    def initialize(board_size, num_colors=6)
      @game_over = false
      @board = Board.new(board_size)
      @code = Code.new(num_colors)
    end

    def play
      @board.print_board(@code.secret)
    end
end

class Hole
  attr_accessor :color
  def initialize(color=nil)
    @color = color
  end
end

class Code
  attr_reader :secret, :colors
  
  def initialize(num)
    colors = ["White", "Black", "Red", "Green", "Orange", "Yellow"]
    until colors.length == num
      colors.pop
    end

    @secret = code(colors)
  end
  
  def code(colors)
    arr = Array.new
    4.times { |i|
      arr.push(colors.sample[0])
    }
    return arr
  end

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

  def print_board(code)
    first_row = "C: "
    code.each {|el| first_row += " #{el}"}
    puts first_row
    
    board.each_with_index do |row, idx|
      i = (idx + 1).to_s
      i = " #{i}" if i.length < 2
      row_print = "#{i} "

      row.each do |hole|
        hole.color == nil ? row_print += " X" : row_print += " #{hole.color[0]}"
      end
      puts row_print

    end
  end
end

new_game = Mastermind.new(12, 4)
new_game.play