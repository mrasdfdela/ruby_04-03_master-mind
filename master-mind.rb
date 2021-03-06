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
    @player_AI = PlayerAI.new(@player.role, @board)
  end

  def play
    code = @board.code.secret
    game_over = false

    until game_over == true || @board.guess_count > 12
      @board.print_board # use optional parameter 'code' to display the secret code

      if @player.role == 'breaker'
        guess = @player.get_valid_guess(@board.color_options)
      else
        guess = @player_AI.guess
      end

      print "\nThe guess is: #{guess}\n"
      @board.update_row(guess)

      @board.guess_count += 1
      game_over = @board.eval_guess(guess, @player.role)
    end
    @board.print_board(code)
  end
end

new_game = Mastermind.new
new_game.play