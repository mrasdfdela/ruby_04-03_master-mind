module SelectColors
  # module for players color selection
  def get_valid_colors(msg, color_options)
    color_options.each { |el| msg += " #{el}" }

    err_msg = ''
    valid_code = false
    until valid_code == true
      puts err_msg + msg
      input = gets.chomp.split(',')
      input.map! { |el| el.strip.capitalize }

      valid_code = validate_input(input, color_options)
      err_msg = 'Invalid input. '
    end

    input
  end

  def validate_input(input, color_options)
    validate_input_length(input) && validate_input_options(input, color_options)
  end

  def validate_input_length(input)
    input.length == 4
  end

  def validate_input_options(input, color_options)
    input.all? do |el|
      color_options.include?(el)
    end
  end
end

module ValidateEntry
  # Generic method for validating user input from a pre-set array
  def validate_entry(msg,arr)
    valid_size = false
    invalid_msg = ''

    until valid_size == true
      puts invalid_msg + msg
      # num = arr.max # pre-selected for testing purposes
      num = gets.chomp.to_i

      if num.is_a?(Numeric) && arr.include?(num)
        valid_size = true
        return num
      end
      invalid_msg = 'Invalid entry. '
    end
  end
end

module CountColors
  def count_colors(arr)
    count = Hash.new
    arr.each do |el|
      el = el[0]
      count[el] ? count[el] += 1 : count[el] = 1
    end
    count
  end
end