module Guesses
  def get_valid_guess(colors)
    guesses = []
    err_msg = ''
    msg = initial_message(colors)

    until guess_valid(guesses, colors)
      puts err_msg + msg
      if @player.role == 'breaker'
        guesses = guess_colors
      elsif @player.role == 'maker'
        guesses = ai_guess_colors(colors)
      end
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

  def ai_guess_colors(colors)
    puts "hello world!"
    # generate all possibilities
    set = full_set(colors)
    # evaluate starter guess
    starter = [colors[0], colors[0], colors[1],colors[1]]

      # eliminate guesses based on results
    # iterate through remaining guesses
  end

  def full_set(c)
    all = []
    i = c.length
    (0...i).each do |j|
      (0...i).each do |k|
        (0...i).each do |l|
          (0...i).each do |m|
            possibility = c[j], c[k], c[l], c[m]
            all.push(possibility, element_count(possibility))
          end
        end
      end
    end
    
    byebug
  end

  def element_count(array)
    count = Hash.new
    array.each do |el|
      count[el] ? count[el] += 1 : count[el] = 1
    end
    count
  end

  def eval_guess
end