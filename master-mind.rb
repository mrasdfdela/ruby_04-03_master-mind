require 'byebug'
require './master-mind-players'
require './master-mind-set-board'
require './master-mind-guesses'
require './master-mind-eval-guesses'
require './master-mind-create-code'

class Mastermind
  include Players
  include CreateCode
  include SetBoard
  include Guesses
  include EvalGuesses
  # Mastermind game
  attr_accessor :colors, :player_AI, :guesses
  attr_reader :game_over, :num_colors, :board, :code, :player

  def self.colors
    @@colors
  end

  def self.pop_color
    @@colors.pop
  end

  def initialize()
    @game_over = false
    @@colors = %w[White Black Red Green Orange Yellow]
    
    @player = Player.new
    @player_AI = PlayerAI.new(@@colors) if @player.role == 'maker'
    @board = Board.new
    @num_colors = @board.num_colors
    @code = Code.new(num_colors, @@colors, @player.role)
  end

  def play
    code = @code.secret
    @game_over = false

    until @game_over == true || @board.guess_count > 12
      @board.guess_count += 1
      # print board, get (valid) guess from user, and update board
      @board.print_board(code)
      @guesses = get_valid_guess(@@colors)
      update_row(@board.board)

      # evaluates if the current guess is correct 
      if eval_all_correct(@guesses, code)
        puts "Correct! You have won!"
        @game_over = true 
      end

      # evaluates and returns the number of correct guesses (color & position)
      correct_color_and_position = eval_colors_and_pos(@guesses, code)
      @board.new_guess_results(correct_color_and_position)
    end

    puts "You have run out of guesses! Game over!" if @board.guess_count == 12
    byebug
  end
end

class Hole
  # Holes within the board
  attr_accessor :color
  def initialize(color=nil)
    @color = color
  end
end

new_game = Mastermind.new
new_game.play