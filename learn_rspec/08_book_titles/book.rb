class Book
	attr_reader :title

	def title=(str)
		words = str.split
		words = [words[0].capitalize] +
			words[1..-1].map do |werd|
				excludeWords = %w{a an and in of the}
				unless excludeWords.include? werd
					werd.capitalize
				else
					werd
				end
			end
		@title = words.join(" ")
	end
end