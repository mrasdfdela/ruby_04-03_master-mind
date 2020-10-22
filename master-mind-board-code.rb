require './master-mind-modules'

class Code
  include SelectColors
  # Secret code (auto-generated or user-specified)
  attr_reader :color_options, :role, :secret

  def initialize(color_options, role)
    @color_options = color_options
    @role = role
    @secret = create_code
  end

  def create_code
    if @role == 'breaker'
      generate_code_auto
    elsif @role == 'maker'
      generate_code_user
    end
  end

  def generate_code_auto
    arr = Array.new
    4.times { |i| arr.push(color_options.sample[0]) }
    return arr
  end
  
  def generate_code_user
    msg = 'Create a comma-separated code using these options: '
    code = get_valid_colors(msg, @color_options)
    return code
  end
end