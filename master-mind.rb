require 'byebug'
require './master-mind-inputs'
require './master-mind-guesses'
include Inputs
include Guesses

class Mastermind
  # Mastermind game
  attr_accessor :colors, :guesses
  attr_reader :game_over, :num_colors, :board, :code

  def initialize()
    @game_over = false

    @@colors = %w[White Black Red Green Orange Yellow]
    @num_colors = select_num_colors
    @code = Code.new(num_colors, @@colors)

    board_size = select_board_size
    @board = Board.new(board_size)
  end

  def self.colors
    @@colors
  end

  def self.pop_color
    @@colors.pop
  end

  ## Review this
  def update_row
    game_board = @board.board
    game_board.each do |row|
      if row[0].color == nil
        import_guess(row, @guesses)
        break
      end
    end  
  end

  def eval_guess(guesses)
    correct_guess = true

    @code.secret.each_with_index do |el, idx|
      correct_guess = false if el != guesses[idx][0]
    end
  end

  def play
    @board.print_board(@code.secret)

    @game_over = false
    until @game_over == true
      # player guesses 4 colors in sequence
      @guesses = get_valid_guess(@@colors)
      byebug
      update_row
      eval_guess(@guesses)
      @board.print_board(code.secret)
      # evaluate whether all guesses are valid
        # re-guess until all guesses are valid
      # count the number of correct colors
        # create an associative array color_count
        # cross-reference guess array w/ color_count
        # create an associative array for correct_color_count & correct_color_position_count
      # count the number of correct colors & positions; 
        # cross-referernce arrays;  
        # for each correct count & position, +1 count and -1 correct color count
    end
  end
end

class Hole
  # Holes within the board
  attr_accessor :color
  def initialize(color=nil)
    @color = color
  end
end

class Code
  # Secret code (auto-generated or user-specified)
  attr_reader :secret, :colors

  def initialize(num,colors)
    until Mastermind.colors.length == num
      Mastermind.pop_color
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
  # Where the board, secret code, and guesses are kept
  attr_accessor :board
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

new_game = Mastermind.new
new_game.play