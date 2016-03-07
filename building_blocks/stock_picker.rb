def stock_picker(stock_array)
	buy = 0
	sell = 1
	difference = 0
	days = stock_array.length - 1
	count = 0

	while count < stock_array.length - 2
		i = 0
		while i < stock_array.length - 1	
			if (stock_array[count] - stock_array[i + 1]) < difference
				buy = count
				sell = i + 1
				difference = (stock_array[count] - stock_array[i + 1])
			end
			i += 1
		end
		count += 1
		i = count
	end
	best = [buy, sell]
	return best.inspect
end

puts stock_picker([17,3,6,9,15,8,6,1,10])
puts stock_picker([1,3,6,9,12])
puts stock_picker([12,9,6,13])
puts stock_picker([1,1,1])