module Inputs
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
      num = gets.chomp.to_i
      if num.is_a?(Numeric) && arr.include?(num)
        valid_size = true
        return num
      end
      invalid_msg = 'Invalid entry. '
    end
  end
end