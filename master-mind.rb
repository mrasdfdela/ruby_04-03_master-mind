require 'byebug'

class Mastermind
  # variables
    # available colors
    attr_reader :game_over, :num_colors, :board, :code

  # start game
    # initialize maker - select color pattern
    # create color counter
  def initialize()
    @game_over = false
    
    @@colors = ["White", "Black", "Red", "Green", "Orange", "Yellow"]
    @num_colors = get_num_colors
    @code = Code.new(num_colors, @@colors)

    board_size = get_board_size
    @board = Board.new(board_size)
  end

  def get_num_colors
    num_colors = [4,5,6]
    msg = "How many colors would you like to play with? Select a number between 4 & 6:"
    valid_entry(msg,num_colors)
  end

  def get_board_size
    size_options = [8,10,12]
    msg = "What size board would you like to play with? Select 8, 10, or 12:"
    valid_entry(msg, size_options)
  end
  
  def valid_entry(msg,arr)
    valid_size = false
    invalid_msg = ""

    until valid_size == true
      puts invalid_msg + msg
      num = gets.chomp.to_i
      if num.is_a?(Numeric) && arr.include?(num)
        valid_size = true
        return num
      end
      invalid_msg = "Invalid entry. "
    end
  end

  def self.colors
    @@colors
  end

  def play_turn

  end

  def play
    @board.print_board(@code.secret)

    @game_over = false
    until @game_over == true
      byebug
    end
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
  
  def initialize(num,colors)
    
    until Mastermind.colors.length == num
      Mastermind.colors.pop
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

new_game = Mastermind.new()
new_game.play