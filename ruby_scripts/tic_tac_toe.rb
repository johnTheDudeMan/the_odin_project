class Player
	attr_accessor :name, :value
	def initialize(name, value)
		@name = name
		@value = value
	end
end

class Game
	@@cells = [1,2,3,4,5,6,7,8,9]
	@@lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
	@@turns = 1

	def initialize(player1, player2)
		@player1 = Player.new(player1, "X")
		@player2 = Player.new(player2, "O")
	end

	def play
		board
		player = players_turn
		get_choice = players_choice(player)
		cell_value(get_choice, player.value)
		if winner?
			board
			puts "'#{player.value}' WON !!!   Nice Job #{player.name}!"
			puts ""
			play_again
		elsif tie?
			puts "Cat's Game - there is no winner"
			play_again
		else
			@@turns += 1
			play
		end
	end

	private

	def board
		puts "   |   |   "
		puts " #{@@cells[0]} | #{@@cells[1]} | #{@@cells[2]} "
		puts "___|___|___"
		puts "   |   |   "
		puts " #{@@cells[3]} | #{@@cells[4]} | #{@@cells[5]} "
		puts "___|___|___"
		puts "   |   |   "
		puts " #{@@cells[6]} | #{@@cells[7]} | #{@@cells[8]} "
		puts "   |   |   "
	end

	def players_turn
		@@turns.odd? ? @player1 : @player2
	end

	def players_choice(player)
		puts "#{player.name} your are '#{player.value}', select your cell:"
		input = gets.chomp.to_i
		if valid_cell?(input)
			return input
		else
			puts "!!! Invalid Choice!!! Try again:"
			players_choice(player)
		end
	end

	def valid_cell?(input)
		if input.between?(1,9)
			return false if @@cells[input - 1] =~ /\D/
			true
		else 
			false
		end
	end

	def cell_value(cell, value)
		@@cells[cell - 1] = value
		@@lines.map! do |e|
			e = e.map {|v| v == cell ? value : v}
		end
	end

	def winner?
		@@lines.any? do |e|
			e.all? {|v| v == players_turn.value}
		end
	end

	def tie?
		@@cells.all? {|e| e =~ /\D/}
	end

	def play_again
		puts "Do you want to play again?"
		ask_to_play = gets.chomp.downcase
		if ask_to_play[0] == "y"
			@@cells = [1,2,3,4,5,6,7,8,9]
			@@lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
			play
		else
			puts "Thanks for playing, don't let the irb hit you on your way out."
		end
	end
end

game1 = Game.new("Arya", "Baci")
game1.play
