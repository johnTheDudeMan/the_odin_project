dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(str, dictionary_supplied = dictionary)
	words = str.downcase.split(/\W/)
	matches = Hash.new(0)
	words.each do |word|
		dictionary_supplied.each do |dict_word|
			if word.include? dict_word
				matches[dict_word] += 1
			end
		end
	end
	puts matches
end

substrings("Howdy partner, sit down! How's it going?", dictionary)
substrings("My name is John, and this is me testing things out and this is me repeating words.", ["my","me", "this", "and", "john", "test", "words"])