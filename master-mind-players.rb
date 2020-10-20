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
end