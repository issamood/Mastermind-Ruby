#Mastermind
class Mastermind
    @@board
    @@player_score
    @@cpu_score
    @@code
    @@round_count

    @@guesses
    @@hints


    @@codebreaker
    @@codemaker

    def initialize(guess_limit)
        @@board = Array.new(guess_limit, Array.new(4));
        @@code = [rand(6),rand(6),rand(6),rand(6)];

        @@guesses = [[1,2,3,4],[1,2,3,4]]
        @@hints = [[x,x,x,x],[x,x,x,x]]

        @@player_score = 0
        @@cpu_score = 0
        @@round_count = 0
    end

    def print_board
        #Prints Outline of board with pegs on right side with each guess printed every round
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\\"
        puts '$$                                                                                                         |'
        puts '$$  $$\      $$\                       $$\                                       $$\                 $$\   |'
        puts '$$  $$$\    $$$ |                      $$ |                                      \__|                $$ |  |'
        puts '$$  $$$$\  $$$$ | $$$$$$\   $$$$$$$\ $$$$$$\    $$$$$$\   $$$$$$\  $$$$$$\$$$$\  $$\ $$$$$$$\   $$$$$$$ |  |'
        puts '$$  $$\$$\$$ $$ | \____$$\ $$  _____|\_$$  _|  $$  __$$\ $$  __$$\ $$  _$$  _$$\ $$ |$$  __$$\ $$  __$$ |  |'
        puts '$$  $$ \$$$  $$ | $$$$$$$ |\$$$$$$\    $$ |    $$$$$$$$ |$$ |  \__|$$ / $$ / $$ |$$ |$$ |  $$ |$$ /  $$ |  |'
        puts '$$  $$ |\$  /$$ |$$  __$$ | \____$$\   $$ |$$\ $$   ____|$$ |      $$ | $$ | $$ |$$ |$$ |  $$ |$$ |  $$ |  |'
        puts '$$  $$ | \_/ $$ |\$$$$$$$ |$$$$$$$  |  \$$$$  |\$$$$$$$\ $$ |      $$ | $$ | $$ |$$ |$$ |  $$ |\$$$$$$$ |  |'
        puts '$$  \__|     \__| \_______|\_______/    \____/  \_______|\__|      \__| \__| \__|\__|\__|  \__| \_______|  |'
        puts "$$  -----------------------------------------------------------------------------------------------------  |"
        
        
        self.guesses.each do |guess_round|
            guess_round.each do |guess|
                puts "$$  #{guess[0]} #{guess[1]} #{guess[2]} #{guess[3]}     |     #{hint[0]} #{hint[1]} #{hint[2]} #{hint[3]}  |"
            end 
        end
    end

    def win
        if self.codebreaker == 'player'
            self.player_score += 1
        elsif self.codebreaker == 'cpu'
            self.cpu_score += 1
        end

    end

    def role_switch
        if (codebreaker == 'player')
            codebreaker == 'cpu'
            codemaker == 'player'
        end
    end

    def reset_game
    end

    def next_round
        if self.round_count != guesses
            
            self.print_board
            self.round_count += 1
        end
    end

    def take_guess
        #Check is guess is valid before entering data
        loop do
            valid = false
            puts "Enter Code:"
            guess = gets.to_s.scan
            if guess.length == 4 && guess.[0] == (0..5) && guess.[1] == (0..5) && guess.[2] == (0..5) && guess.[3] == (0..5)
                valid = true
            else
                puts 'Error invalid code, please enter a 4-digit code from the range 0~5. e.g. 0523'
            breaks if valid == true
        end

        #Just win if correct code
        if (guess == self.code)
            self.win
        end

        #Else continue game
        #Updates internal round, guess, and hint history
        for i in 0..3 do
            if guess[i] == code[i]
                self.hints[round_count][i] = 'o'
            elsif code[i].include? guess[i]
                self.hints[round_count][i] = 'x'
            else
                self.hints[round_count][i] = '_'
            end
            self.guesses.push[round_count][i] =  guess[i]
        end
        round_count+= 1
    end
end

#Get rounds input from user
def get_rounds
    puts 'Select number of guesses:'
    puts '1. 12 (easy)'
    puts '2. 10 (medium)'
    puts '3. 8  (hard)'
    while (user_selects != 1 && user_selects != 2 && user_selects != 3)
        puts 'Please select a number from 1 through 3: '
        user_selects = gets
    end
    case user_selects
    when 1
        return 12
    when 2
        return 10
    when 3
        return 8
    end
end

#Game Start
puts 'Welcome to Mastermind!'
game = Mastermind.new(get_rounds)