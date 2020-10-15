module Guesses
  def get_valid_guess(colors)
    guesses = []
    err_msg = ''
    msg = initial_message(colors)

    until guess_valid(guesses, colors)
      puts err_msg + msg
      guesses = guess_colors
      err_msg = 'Invalid input. '
    end

    return guesses
  end

  def initial_message(colors)
    msg = ''
    colors.each do |color|
      msg = "#{msg}, " if msg != ''
      msg += color
    end
    "Guess the sequence in a comma-separated list of of 4 colors: " + msg
  end

  def guess_colors
    guesses = gets.chomp.split(',')
    guesses.map! do |guess| 
      guess.strip.capitalize
    end
  end

  def guess_valid(guesses, colors)
    g = guesses
    g.length == 4 && g.all? { |guess| colors.include?(guess) }
  end

  def import_guess(row, guesses)
    row.each_with_index do |el, idx|
      el.color = guesses[idx]
    end
  end

  def update_row(board)
    board.each do |row|
      if row[0].color == nil
        import_guess(row, @guesses)
        break
      end
    end
  end
end