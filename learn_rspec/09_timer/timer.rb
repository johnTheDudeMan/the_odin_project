class Timer
	attr_accessor :seconds
	attr_accessor :minutes
	attr_accessor :hours

	def initialize
		@seconds = 0
	end

	def padded(int)
		if int < 10
			"0" + int.to_s
		else
			int.to_s
		end
	end

	def time_string
		if @seconds < 60
			"00:00:#{padded(@seconds)}"
		elsif @seconds < 3600
			@minutes = (@seconds - (@seconds % 60)) / 60
			@seconds = @seconds % 60
			"00:#{padded(@minutes)}:#{padded(@seconds)}"
		else
			@hours = (((@seconds - (@seconds % 60)) / 60) - (((@seconds - (@seconds % 60)) / 60) % 60)) / 60
			@minutes = ((@seconds - (@seconds % 60)) / 60) % 60
			@seconds = @seconds % 60
			"#{padded(@hours)}:#{padded(@minutes)}:#{padded(@seconds)}"
		end
	end
end