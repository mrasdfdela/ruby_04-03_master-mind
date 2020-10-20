module Players
  class Player
    # for selecting player to be a code maker or breaker
    attr_reader :role
    def initialize
      @role = select_role
    end

    def select_role
      msg = 'Would you like to be a code maker or code breaker? [maker : breaker]'
      error_msg = ''

      choices = %w(maker breaker)
      choice = ''
      role_selected = false
      until role_selected == true
        puts error_msg + msg

        # for testing 'maker' option
          choice = 'maker'
        # choice = gets.chomp.downcase
        role_selected = true if choices.include?(choice)
        error_msg = 'Invalid selection. '
      end
  
      return choice
    end
  end

  class PlayerAI
    attr_accessor :set, :starter
    
    def initialize(colors)
      @set = full_set(colors)
      # generate all possibilities
      @starter = [colors[0], colors[0], colors[1],colors[1]]
    end

    def full_set(c)
      all = []
      i = c.length
      (0...i).each do |j|
        (0...i).each do |k|
          (0...i).each do |l|
            (0...i).each do |m|
              combo = c[j], c[k], c[l], c[m]
              all.push(SetElement.new(combo))
            end
          end
        end
      end
      all
    end

    def ai_guess_colors
      if @set.length == 1296
        remove_from_set_guess(@starter)
        return @starter
      else 
        # eliminate guesses based on results
        guess = @set.sample.combo
        remove_from_set_guess(guess)
        remove_from_set_count(guess)
        return guess
      end
    end

    def remove_from_set_guess(guess)
      @set.each_with_index do |el, idx|
        @set.slice!(idx) if el.combo == guess
      end
    end

    def remove_from_set_count(guess)
      guess_count = color_count(guess)
      guess_count.each do |k, v|
        @set.each_with_index do |el, idx|

        end
      end
    end

    def color_count(guess)
      byebug
      guess_count = Hash.new
      guess.each do |el|
        el = el[0]
        guess_count[el] ? guess_count[el] += 1 : guess_count[el] = 1
      end
      guess_count
    end
  end

  class SetElement
    attr_accessor :combo, :count
    def initialize(colors)
      @combo = colors
      @count = el_count(colors)
    end

    def el_count(arr)
      count = Hash.new
      arr.each do |el|
        count[el] ? count[el] += 1 : count[el] = 1
      end
      count
    end
  end
end