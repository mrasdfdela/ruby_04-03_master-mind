require 'byebug'
require './master-mind-set-board'
require './master-mind-guesses'
require './master-mind-eval-guesses'

class Mastermind
  include SetBoard
  include Guesses
  include EvalGuesses
  # Mastermind game
  attr_accessor :colors, :guesses
  attr_reader :game_over, :num_colors, :board, :code

  def self.colors
    @@colors
  end

  def self.pop_color
    @@colors.pop
  end

  def initialize()
    @game_over = false

    @@colors = %w[White Black Red Green Orange Yellow]
    @num_colors = select_num_colors
    @code = Code.new(num_colors, @@colors)

    board_size = select_board_size
    @board = Board.new(board_size)
  end

  def play
    code = @code.secret
    @game_over = false

    until @game_over == true
      # player guesses 4 colors in sequence
      @board.print_board(code)
      # evaluate whether all guesses are valid
        # re-guess until all guesses are valid
      @guesses = get_valid_guess(@@colors)
      update_row(@board.board)

      if eval_all_correct(@guesses, code)
        puts "Correct! You have won!"
        @game_over = true 
      end

      correct_color_and_position = eval_colors_and_pos(@guesses, code)
      @board.new_guess_results(correct_color_and_position)
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
    4.times { |i| arr.push(colors.sample[0]) }
    return arr
  end
end

class Maker
end

class Guesser
end

class Board
  # Where the board, secret code, and guesses are kept
  attr_accessor :board, :guess_results
  def initialize(guesses)
    @board = Array.new(guesses) {
      Array.new(4) {
        Hole.new()
      }
    }
    @guess_results = []
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

      if guess_results[idx]
        r = guess_results[idx]
        row_print += " color => #{r['color_count']} pos => #{r['position_count']}"
      end

      puts row_print
    end
  end

  def new_guess_results(hash)
    @guess_results.push(hash)
  end
end

new_game = Mastermind.new
new_game.play