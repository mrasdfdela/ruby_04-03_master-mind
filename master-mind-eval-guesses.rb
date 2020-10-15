module EvalGuesses
  def eval_all_correct(guesses, code)
    correct_guess = true

    code.each_with_index do |el, idx|
      correct_guess = false if el != guesses[idx][0]
    end

    correct_guess
  end

  def eval_colors_and_pos(guesses, code)
    code_count = count_colors(code)
    guess_count = count_colors(guesses)

    color_count = correct_color_count(code_count, guess_count)
    color_and_pos = correct_color_and_pos(guesses, code, color_count)
  end

  def count_colors(arr)
    count = Hash.new
    arr.each do |el|
      el = el[0]
      count[el] ? count[el] += 1 : count[el] = 1
    end
    count
  end

  def correct_color_count(code_count, guess_count)
    count = 0
    
    code_count.each do |k, v|
      if guess_count[k]
        guess_count[k] > v ? count += v : count += guess_count[k]
      end
    end
    
    count
  end

  def correct_color_and_pos(guesses, code, color_count)
    counts = { "position_count" => 0, "color_count" => color_count }
    
    guesses.each_with_index do |guess, idx|
      if guess[0] == code[idx]
        counts['color_count'] -= 1
        counts['position_count'] += 1
      end
    end
    
    counts
  end
end