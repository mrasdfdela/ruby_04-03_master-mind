module SetBoard
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
      # Code between these hashes are for testing purposes
      num = arr.max
      # num = gets.chomp.to_i
      
      if num.is_a?(Numeric) && arr.include?(num)
        valid_size = true
        return num
      end
      invalid_msg = 'Invalid entry. '
    end
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
          row_print += " correct position => #{r['position_count']} color only => #{r['color_count']} "
        end
  
        puts row_print
      end
    end
  
    def new_guess_results(hash)
      @guess_results.push(hash)
    end
  end
end