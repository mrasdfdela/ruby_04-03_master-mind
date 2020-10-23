module GuessingAlgorithm
  # for handling AI logic in guessing user-selected code
  def guess
    if color_count_total < 4
      c = @color_options[@color_count_idx]
      output = [c,c,c,c]
      color_count_update(c)
      remove_from_set_color(c)
      @color_count_idx += 1
    else
      puts "...sampling phase..."
      output = @set.sample.combo
      byebug
    end
    remove_from_set_guess(output)
    
    output
  end

  def color_count_total
    count = 0
    @color_count.each do |k, v|
      count += v
    end
    count
  end

  def color_count_update(eval_color)
    @board.code.secret.each do |color|
      if color == eval_color
        @color_count[color] ? @color_count[color] += 1 : @color_count[color] = 1
      end
    end
  end

  def guess_color(c)
    guess = [c, c, c, c]
  end

  ### Need a method to count the correct colors in the previous turn

  def remove_from_set_guess(output)
    @set.each_with_index do |el, idx|
      @set.slice!(idx) if el.combo == output
    end
  end

  def remove_from_set_color(color)
    @set.each_with_index do |el, idx|
      @set.slice!(idx) if el.count[color] != @color_count[color]
    end
  end

end