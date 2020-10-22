require './master-mind-board-print'

class Board
  include BoardPrint
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

  def select_num_colors
    num_colors = [4, 5, 6]
    msg = 'How many colors would you like to play with? Select a number between 4 & 6:'
    valid_entry(msg,num_colors)
  end

  def select_board_size
    size_options = [8, 10, 12]
    msg = 'What size board would you like to play with? Select 8, 10, or 12:'
    valid_entry(msg, size_options)
  end

  def valid_entry(msg,arr)
    valid_size = false
    invalid_msg = ''

    until valid_size == true
      puts invalid_msg + msg
      num = arr.max # pre-selected for testing purposes
      # num = gets.chomp.to_i

      if num.is_a?(Numeric) && arr.include?(num)
        valid_size = true
        return num
      end
      invalid_msg = 'Invalid entry. '
    end
  end

  def set_color_options
    starting_colors = %w[White Black Red Green Orange Yellow]
    until starting_colors.length == @num_colors
      starting_colors.pop
    end
    starting_colors
  end

  def new_guess_results(hash)
    @guess_results.push(hash)
  end

  def import_guess(row, guesses)
    row.each_with_index do |el, idx|
      el.color = guesses[idx]
    end
  end

  def update_row(board)
    board.each do |row|
      if row[0].color == nil
        import_guess(row, @guesses)
        break
      end
    end
  end

  def eval_all_correct(guesses, code)
    correct_guess = true

    code.each_with_index do |el, idx|
      correct_guess = false if el != guesses[idx][0]
    end

    correct_guess
  end

  def eval_colors_and_pos(guesses, code)
    code_count = count_colors(code)
    guess_count = count_colors(guesses)

    color_count = correct_color_count(code_count, guess_count)
    color_and_pos = correct_color_and_pos(guesses, code, color_count)    
    byebug
    @player_AI.color_count += color_count

  end

  def count_colors(arr)
    count = Hash.new
    arr.each do |el|
      el = el[0]
      count[el] ? count[el] += 1 : count[el] = 1
    end
    count
  end

  def correct_color_count(code_count, guess_count)
    count = 0
    
    code_count.each do |k, v|
      if guess_count[k]
        guess_count[k] > v ? count += v : count += guess_count[k]
      end
    end
    
    count
  end

  def correct_color_and_pos(guesses, code, color_count)
    counts = { "position_count" => 0, "color_count" => color_count }
    
    guesses.each_with_index do |guess, idx|
      if guess[0] == code[idx]
        counts['color_count'] -= 1
        counts['position_count'] += 1
      end
    end
    
    counts
  end
end

class Row
  # Holes within the board
  attr_accessor :holes, :correct_positions, :correct_colors
  def initialize
    @holes = Array.new(4){nil}
    @correct_positions = nil
    @correct_colors = nil
  end
end