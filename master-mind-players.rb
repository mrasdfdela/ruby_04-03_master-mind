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

        choice = gets.chomp.downcase
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
      byebug
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
      puts guess
      if @set.length == 1296
        remove_el_from_set(@starter)
        return @starter
      else 
        # eliminate guesses based on results
        guess = @set.sample.combo
        remove_el_from_set(guess)
      end
    end

    def remove_el_from_set(guess)
      @set.each_with_index do |el, idx|
        @set.slice!(idx) if el.combo == @starter
      end
    end

    def eval_colors(colors)

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