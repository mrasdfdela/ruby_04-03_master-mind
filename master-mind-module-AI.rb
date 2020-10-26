module GuessingAlgorithm
  # for handling AI logic for guessing user-created code
  def guess
    if @seeding_phase == true
      @seeding_phase = false
      output = @starter
    else
      eval_previous_turn
      output = @set.sample.combo
    end

    @set.delete_if { |row| row.combo == output }
    output
  end

  def eval_previous_turn
    idx = last_guess_idx
    eval_previous_turn_colors(idx)
    eval_previous_turn_positions(idx)
  end

  def last_guess_idx
    @board.board.each.with_index do |row, idx|
      if row.correct_positions.nil?
        return (idx - 1)
        break
      end
    end
  end

  def eval_previous_turn_colors(idx)
    guessed_row = @board.board[idx]
    color_count = guessed_row.correct_positions + guessed_row.correct_colors

    @set.delete_if do |row|
      matched_colors = 0

      row.count.each do |k, num|
        if num.nil? || guessed_row.count[k].nil?

        elsif num == guessed_row.count[k]
          matched_colors += num
        else
          matched_colors += [num, guessed_row.count[k]].min
        end
      end

      color_count != matched_colors
    end
  end

  def eval_previous_turn_positions(idx)
    guessed_row = @board.board[idx]

    @set.delete_if do |row|
      matched_positions = 0
      row.combo.each_with_index do |color,idx|
        matched_positions += 1 if color == guessed_row.holes[idx]
      end
      guessed_row.correct_positions != matched_positions
    end
  end
end