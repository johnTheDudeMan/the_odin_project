class Codemaker

	def initialize
		@@code = []
		@@guesses = []
		@@feedbacks = []
	end

	def guessed_correct?
		return true if @@code == @@guesses.last
	end

	def feedback
		feedback_round = []
		guessed = Array.new(@@guesses.last)
		coded = Array.new(@@code)
		guessed.each_with_index do |e, i|
			if e == coded[i]
				feedback_round << "X"
				guessed[i] = ""
				coded[i] = "X"
			end
		end
		guessed.each do |e|
			if coded.index(e)
				feedback_round << "O"
				coded[coded.index(e)] = "O"
			end
		end
		@@feedbacks << feedback_round.shuffle!
		feedback_round
	end

	def show_results
		30.times{puts "\n "}
		puts "\n\t::Round:: \t >> Code Breaker << \t::Code Feedback::"
		@@guesses.each_with_index do |e, i|
			puts "\t   #{i + 1}\t\t\t#{e.join(",")}\t\t   #{@@feedbacks[i].join}"
		end
		puts "\n\t X - indicates a correct match found at correct spot"
		puts "\t O - indicates a correct match found but not at correct spot"
	end
end

class Computer < Codemaker
	def make_code
		@@code = [] if @@code != []
		rand_code = []
		4.times {rand_code << random_peg}
		@@code = rand_code
	end

	def random_peg
		["Q","W","E","R","T","Y"].sample
	end

	def guess_code
		guess = []
		if @@feedbacks.empty?
			4.times {guess << random_peg}
		else
			code_copy = Array.new(@@code)
			correct = [nil,nil,nil,nil]
			not_correct = [nil,nil,nil,nil]
			do_not_reuse = []
			@@guesses.last.each_with_index do |e, i|
				if e == @@code[i]
					correct[i] = e
					code_copy[i] = "X"
				else
					not_correct[i] = e
				end
			end
			not_correct.each do |e|
				if e != nil && code_copy.index(e) && !do_not_reuse.index(e)
					indx = 0
					while indx < 4
						if correct[indx] == nil
							correct[indx] = e unless not_correct[indx] == e
						end
						indx += 1
					end
				else
					do_not_reuse << e
				end
			end
			correct.each do |e|
				if e
					guess << e
				else
					new_peg = random_peg
					while do_not_reuse.index(new_peg)
						new_peg = random_peg
					end
					guess << new_peg
				end
			end
		end
		@@guesses << guess
	end
end

class Human < Codemaker
	def make_code
		puts "\nHuman, you are the codemaker. The computer will try to guess your code."
		puts "Enter any 4 letter combination from >> Q-W-E-R-T-Y << (duplicates allowed):"
		input = gets.chomp.upcase
		validate_input(input) ? @@code = input.split("") : make_code
		30.times {puts "\n "}
	end

	def validate_input(input)
		if input =~ /[QWERTY]{4}/ && input.size == 4
			true
		else
			puts "\n\t\tERROR:::Invalid Input:::ERROR\n\tSelect only from Q-W-E-R-T-Y. You can use same letter multiple times."
		end
	end

	def guess_code
		puts "\nGuess any 4 letter combination from >> Q-W-E-R-T-Y << (duplicates allowed):"
		input = gets.chomp.upcase
		validate_input(input) ? @@guesses << input.split("") : guess_code
	end
end


class Mastermind
	def initialize
		play
	end

	def select_codemaker
		30.times {puts "\n "}
		puts "\nDo you want to be the codemaker? (else you will guess the code)"
		input = gets.chomp.downcase
		if input[0] == "y"
			@codemaker = Human.new
			@codebreaker = Computer.new
		else
			@codemaker = Computer.new
			@codebreaker = Human.new
		end
	end

	def new_game
		@codemaker.make_code
		12.times do
			@codebreaker.guess_code
			@codemaker.feedback
			@codemaker.show_results
			if @codebreaker.guessed_correct?
				puts "\n!!! WINNER WINNER chicken dinner !!!"
				break
			end
		end
		puts "code was: #{@@code}"
		puts "\n\t!!! GAME OVER !!! the code was not broken" unless @codebreaker.guessed_correct?
	end

	def play
		select_codemaker
		new_game
		puts "\nDo you want to play again?"
		input = gets.chomp.downcase
		input[0] == "y" ? play : (puts "Thanks for playing, don't let the irb hit you on your way out!")
	end
end

game = Mastermind.new
