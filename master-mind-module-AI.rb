module PlayerAIguessing
   def current_color
    @colors[@color_count_idx]
  end

  def ai_guess_colors
    i = @colors[@color_count_idx]
    if @color_count <= 4
      guess = [ i, i, i, i ]
      remove_from_set_guess(guess)
      @color_count_idx += 1
      guess
    else
      guess = @set.sample.combo
      remove_from_set_guess(guess)
      remove_from_set_count(guess)
    end
  end

  def remove_from_set_guess(guess)
    @set.each_with_index do |el, idx|
      @set.slice!(idx) if el.combo == guess
    end
  end

end