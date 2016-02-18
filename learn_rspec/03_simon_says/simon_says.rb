def echo(str)
	str
end

def shout(str)
	str.upcase
end

def repeat(str, times=2)
	([str] * times).join(" ")
end

def start_of_word(str, endAtLetter=1)
	str[0, endAtLetter]
end

def first_word(str)
	str.split[0]
end

def titleize(str)
	titled = []
	str.split.each {|x| 
		if x != "the" && x != "and" && x != "over"
			titled << x.capitalize
		else
			titled << x
		end
	}
	titled[0] = titled[0].capitalize
	titled.join(" ")
end