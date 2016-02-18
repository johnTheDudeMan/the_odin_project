def translate(s)
	pigLatin = []
	s.split.each {|word|
		letters = word.split("")
		if letters.length >= 3
			vowels = %w(a e i o u)
			unless vowels.include? letters[0]
				if vowels.include? letters[1]
					if letters[0] == "q" && letters[1] == "u"
						letters << letters[0] << letters[1]
						letters.delete_at(0)
						letters.delete_at(0)
					else	
						letters << letters[0]
						letters.delete_at(0)
					end
				elsif vowels.include? letters[2]
					if letters[1] == "q" && letters[2] == "u"
						letters << letters[0] << letters[1] << letters[2]
						letters.delete_at(0)
						letters.delete_at(0)
						letters.delete_at(0)
					else
						letters << letters[0] << letters[1]
						letters.delete_at(0)
						letters.delete_at(0)
					end
				else
					letters << letters[0] << letters[1] << letters[2]
					letters.delete_at(0)
					letters.delete_at(0)
					letters.delete_at(0)
				end
			end
			letters << "ay"
			pigLatin << letters.join("")
		end
	}
	pigLatin.join(" ")
end