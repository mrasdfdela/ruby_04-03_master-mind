module BoardPrint
  def print_board(code=nil)
    print_secret_code(code) # for testing purpose; uses an optional parameter 'code'

    board.each_with_index do |row, idx|
      i = (idx + 1).to_s
      i = " #{i}" if i.length < 2
      row_print = "#{i} "

      row.holes.each do |hole|
        row_print += add_text(hole, 'X')
      end

      if row.correct_positions
        row_print += " | Positions => #{row.correct_positions}"
        row_print += " | Colors => #{row.correct_colors}"
      end

      puts row_print
    end
    return
  end

  def print_secret_code(code)
    if code
      str = "   "
      code.each { |color| str += add_text(color, '') }
    end
    puts str
  end

  def add_text(el, default)
    el == nil ? str = " #{default}" : str = " #{el[0]}"
  end
end