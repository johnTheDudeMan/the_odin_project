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

puts caesar_cipher("What a string!", 5)