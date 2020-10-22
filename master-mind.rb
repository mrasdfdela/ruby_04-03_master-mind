require 'byebug'
require './master-mind-players'
require './master-mind-board'
require './master-mind-board-code'

class Mastermind
  # Mastermind game
  attr_accessor :colors, :player_AI, :guesses
  attr_reader :player, :board

  
  def initialize()
    @player = Player.new
    @board = Board.new(@player.role)
    @player_AI = PlayerAI.new(@player.role, @board.color_options)
  end

  def play
    code = @board.code.secret
    game_over = false

    until game_over == true || @board.guess_count > 12
      @board.guess_count += 1
      @board.print_board(@board.code.secret) # this is an optional parameter; remove when done
      if @player.role == 'breaker'
        guess = @player.get_valid_guess(@board.color_options)
      else
        guess = @player_AI.guess
      end
      byebug
      update_row(@board.board)

      # evaluates if the current guess is correct 
      if eval_all_correct(@guesses, code)
        puts "Correct! You have won!"
        game_over = true 
      end

      # evaluates and returns the number of correct guesses (color & position)
      correct_color_and_position = eval_colors_and_pos(@guesses, code)
      @board.new_guess_results(correct_color_and_position)
    end

    puts "You have run out of guesses! Game over!" if @board.guess_count == 12
    byebug
  end
end

new_game = Mastermind.new
new_game.play