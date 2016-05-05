def caesar_cipher(str, shift_factor)
	letters = str.split("")
	letters.map! do |letter|
		letter = letter.ord
		if letter >= 65 && letter <= 90
			letter = letter + shift_factor
			if letter > 90
				letter = (letter - 90) + 64
			end
		elsif letter >= 97 && letter <= 122
			letter = letter + shift_factor
			if letter > 122
				letter = (letter - 122) + 96
			end
		end
		letter = letter.chr
	end
	letters.join("")
end

str = "I am the cat of cats"
puts str
str_ciphed = caesar_cipher(str, 5)
puts str_ciphed
puts caesar_cipher(str_ciphed, -5)
str_with_numbers = "How about the number 13"
puts str_with_numbers
puts caesar_cipher(str_with_numbers, 2)