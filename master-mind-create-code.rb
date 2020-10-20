module CreateCode
  class Code
    # Secret code (auto-generated or user-specified)
    attr_reader :secret, :color_options, :role

    def initialize(num, color_options, role)
      @color_options = color_options
      @role = role
      until Mastermind.colors.length == num
        Mastermind.pop_color
      end

      @secret = create_code
    end

    def create_code
      if @role == 'breaker'
        code_auto_generated
      elsif @role == 'maker'
        code_user_generated
      end
    end

    def code_auto_generated
      arr = Array.new
      4.times { |i| arr.push(color_options.sample[0]) }
      return arr
    end

    def code_user_generated
      print_options = ''
      color_options.each do |el|
        print_options += " #{el}"
      end

      msg = "Create a (comma-separated) secret code using these options: #{print_options}"
      err_msg = ''
      valid_code = false
      until valid_code == true
        puts err_msg + msg
        input = gets.chomp.split(',')
        input.map! { |el| el.strip.capitalize }

        valid_code = code_eval_length(input) && code_eval_colors(input)
        err_msg = 'Invalid code. '
      end
      input.map! { |el| el[0] }
    end

    def code_eval_length(eval_code)
      eval_code.length == 4
    end

    def code_eval_colors(eval_code)
      eval_code.all? do |el|
        color_options.include?(el)
      end
    end
  end
end