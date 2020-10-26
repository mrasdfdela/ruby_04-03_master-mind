require './master-mind-board-print'

class Board
  include BoardPrint
  include ValidateEntry
  include CountColors
  # Where the board, secret code, and guesses are kept
  attr_reader :num_colors, :board_size, :color_options
  attr_accessor :board, :guess_results, :guess_count, :code

  def initialize(player_role)
    @board_size = select_board_size
    @num_colors = select_num_colors
    @color_options = set_color_options
    @code = Code.new(@color_options, player_role)
    @guess_count = 0

    @board = Array.new(board_size) { Row.new }
    @guess_results = []
  end

  def select_board_size
    size_options = [8, 10, 12]
    msg = 'What size board would you like to play with? Select 8, 10, or 12:'
    validate_entry(msg, size_options)
  end

  def select_num_colors
    num_colors = [4, 5, 6]
    msg = 'How many colors would you like to play with? Select a number between 4 & 6:'
    validate_entry(msg,num_colors)
  end

  def set_color_options
    starting_colors = %w[White Black Red Green Orange Yellow]
    until starting_colors.length == @num_colors
      starting_colors.pop
    end
    starting_colors
  end

  def update_row(guess)
    board.each do |row|
      if row.holes[0].nil?
        row.holes = guess
        row.correct_positions = correct_color_and_pos(guess, @code.secret)
        row.correct_colors = correct_color_count(guess, @code.secret) - row.correct_positions
        row.count = row.count_colors(guess)
        break
      end
    end
  end

  def correct_color_and_pos(guess, code)
    count = 0
    guess.each_with_index do |hole, i|
      count += 1 if hole == code[i]
    end
    count
  end

  def correct_color_count(guess, code)
    guess_count = count_colors(guess)
    code_count = count_colors(code)

    count = 0
    code_count.each do |k, v|
      if guess_count[k]
        guess_count[k] > v ? count += v : count += guess_count[k]
      end
    end
    count
  end

  def eval_guess(guess)
    game_over = false
    if @code.secret == guess
      puts "Correct! You have won!"
      game_over = true
    elsif @guess_count == @board_size
      puts "You have run out of guesses!"
      game_over = true
    end
    game_over
  end
end

class Row
  # Holes within the board
  include CountColors
  attr_accessor :holes, :correct_positions, :correct_colors, :count
  def initialize
    @holes = Array.new(4){nil}
    @correct_positions = nil
    @correct_colors = nil
  end
end