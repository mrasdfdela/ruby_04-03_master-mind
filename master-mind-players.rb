require './master-mind-modules'
require './master-mind-module-AI'

class Player
  # for selecting player to be a code maker or breaker
  include SelectColors
  attr_reader :role
  def initialize
    @role = select_role
  end

  def select_role
    msg = 'Would you like to be a code maker or code breaker? [maker : breaker]'
    error_msg = ''

    choices = %w(maker breaker)
    choice = ''

    role_selected = false
    until role_selected == true
      puts error_msg + msg

      # for testing 'maker' option
        choice = 'breaker'
      # choice = gets.chomp.downcase
      role_selected = true if choices.include?(choice)
      error_msg = 'Invalid selection. '
    end

    return choice
  end

  def get_valid_guess(colors)
    msg = 'Guess the sequence in a comma-separated list of of 4 colors: '
    get_valid_colors(msg, colors)
  end
end

class PlayerAI
  # for when player is the code maker
  include PlayerAIguessing
  attr_accessor :role, :color_options, :set, :starter, :initial_guess_idx, :color_count
  def initialize(player_role, color_options)
    @role = set_role(player_role)
    @color_options = color_options
    if @role == 'breaker'
      @set = full_set(@color_options) # generate set of potential codes
      @color_count_idx = 0 # indexes which initial color to evaluate
      @color_count = 0 # tracks the number of colors that have been ID'd
    end
  end

  def set_role(player_role)
    player_role == 'maker' ? 'breaker' : 'maker'
  end

  def full_set(c)
    all = []
    i = c.length
    (0...i).each do |j|
      (0...i).each do |k|
        (0...i).each do |l|
          (0...i).each do |m|
            combo = c[j], c[k], c[l], c[m]
            all.push(SetElement.new(combo))
          end
        end
      end
    end
    all
  end
end

class SetElement
  attr_accessor :combo, :count
  def initialize(colors)
    @combo = colors
    @count = el_count(colors)
  end

  def el_count(arr)
    count = Hash.new
    arr.each do |el|
      count[el] ? count[el] += 1 : count[el] = 1
    end
    count
  end
end