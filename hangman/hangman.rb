require 'yaml'
@word = [""]
@misses = 0
@turns = 0
@hangman = []
@letters_correct = []
@letters_wrong = []

def main_menu
	clear_screen
	@letters_correct = []
	@letters_wrong = []
	@misses = 0
	@turns = 0
	clear_hangman
	puts "\t\tMain Menu\n\n"
	puts "Please choose from one of the following options:\n"
	puts "1. New Game"
	puts "2. Load Game"
	puts "3. Exit \n\n"
	input = gets.chomp
	case input
	when "1"
		@word = random_word
		create_letter_board
		play
	when "2"
		load_game
		play
	when "3"
		exit
	else
		main_menu
	end
end

def save_game
	clear_screen
	game_data = {word: @word, misses: @misses, turns: @turns, correct: @letters_correct, wrong: @letters_wrong}.to_yaml
	puts "Name your file to save to:"
	input = gets.chomp
	File.open(input + ".yml", 'w') {|file| file.write(game_data)}
	main_menu
end

def load_game
	clear_screen
	puts "Enter the name of the file to load:"
	input = gets.chomp
	game_data = YAML::load_file(input + ".yml")
	@word = game_data[:word]
	game_data[:misses].times {miss}
	@turns = game_data[:turns]
	@letters_wrong = game_data[:wrong]
	@letters_correct = game_data[:correct]
end

def play
	clear_screen
	until game_over?
		show_hangman
		show_letter_board
		puts "\n\n\nGuess a letter or guess the word: \t (enter 'save' to save the game)"
		input = gets.chomp.downcase
		evaluate_letter(input)
		clear_screen
	end
	puts "\n\n\nThe word was:   #{@word.join("")}"
	puts "\n\t\t(enter any key to continue)"
	gets
	main_menu
end

def random_word
	word = " "
	File.open("words.txt", "r") do |file|
		word = file.readlines[rand(61406)].chomp
	end
	if word.length.between?(5,12) && word == word.downcase
		@word = word.split("")
	else
		random_word
	end
end

def show_hangman
	@hangman.each {|e| puts e}
end

def clear_hangman
	@hangman = [
				"  ;-----||",
				"        ||",
				"        ||",
				"        ||",
				"        ||",
				"        ||",
				"::::::::::"
				]
end

def miss
	@misses += 1
	25.times {puts "\n"}
	case @misses
	when 1
		@hangman[1][2] = "O"
	when 2
		@hangman[2][2] = "|"
		@hangman[3][2] = "|"
	when 3
		@hangman[2][1] = "/"
	when 4
		@hangman[2][3] = "\\"
	when 5
		@hangman[4][1] = "/"
	when 6
		@hangman[4][3] = "\\"
	end
end

def evaluate_word(word)
	if word.split("") == @word
		@letters_correct = word.split("")
	else 
		miss
	end
end

def evaluate_letter(letter)
	if letter == 'save'
		save_game
	elsif letter.length > 1
		evaluate_word(letter)
	elsif @word.include?(letter)
		@word.each_with_index do |e,i| 
			@letters_correct[i] = e if e == letter
		end
	else
		@letters_wrong << letter
		miss
	end
end

def create_letter_board
	@word.length.times {@letters_correct << "_ "}
end

def show_letter_board
	puts "\n\n"
	@letters_correct.each {|e| print e + " "}
	print "\n\n\n\t\t\t Incorrect Letters:  "
	@letters_wrong.each {|e| print e + " "}
end

def game_over?
	if @letters_correct == @word 
		3.times {puts "\n!!! You Win !!! \n"}
		true
	elsif @misses == 6 or @turns == 12
		3.times {puts "\n ***** You Lose ***\n"}
		true
	else
		false
	end
end

def clear_screen
	30.times {puts "\n"}
end

main_menu