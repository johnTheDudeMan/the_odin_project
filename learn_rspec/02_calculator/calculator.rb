def add(a, b)
	a + b
end

def subtract(a, b)
	a - b
end

def sum(numbers)
	numbers.inject(0){|total, number| total + number}.to_i
end