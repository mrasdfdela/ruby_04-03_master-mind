module GuessingAlgorithm
  # for handling AI logic in guessing user-selected code
  def guess
    if color_count_total < 4
      c = @color_options[@color_count_idx]
      output = [c,c,c,c]
      color_count_update(c)
      remove_from_set_color
      @color_count_idx += 1
    elsif @third_phase == false
      @third_phase = true
      output = @set.sample.combo
    else
      remove_matches
      output = @set.sample.combo
    end
    remove_from_set_guess(output)
    output
  end

  def color_count_total
    count = 0
    @color_count.each { |k, v| count += v }
    count
  end

  def color_count_update(eval_color)
    @board.code.secret.each do |color|
      if color == eval_color
        @color_count[color] ? @color_count[color] += 1 : @color_count[color] = 1
      end
    end
  end

  def remove_from_set_guess(output)
    @set.each_with_index do |el, idx|
      @set.slice!(idx) if el.combo == output
    end
  end

  def remove_from_set_color
    # removes the current guess from the set of possible guesses
    @color_count.each do |key,value|
      @set.delete_if do |el|
        el.count[key] != value
      end
    end
  end

  def remove_matches
    # removes previous turn's matches
    @board.board.each_with_index do |row, idx|
      if row.correct_positions.nil?
        match_lookup(@board.board[idx - 1])
        break
      end
    end
  end

  def match_lookup(row)
    # removes elements in the set of possibile guesses based on hints
    correct_positions = row.correct_positions
    @set.delete_if do |el|
      matched_positions = 0

      el.combo.each_with_index do |color,idx|
        matched_positions += 1 if color == row.holes[idx]
      end

      correct_positions != matched_positions
    end
  end
end