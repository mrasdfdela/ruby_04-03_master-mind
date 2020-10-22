module SelectColors
  def get_valid_colors(msg, color_options)
    color_options.each do |el|
      msg += " #{el}"
    end

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