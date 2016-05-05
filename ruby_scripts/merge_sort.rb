
def merge_sort(ary)
	return ary if ary.size == 1

	#divide
	mid = ary.size / 2
	b = ary[0...mid]
	c = ary[mid..-1]

	#conquer
	b = merge_sort(b)
	c = merge_sort(c)

	#merge
	sorted_array = []

	until b.empty? || c.empty?
		if b[0] <= c[0]
			sorted_array << b.shift 
		else
			sorted_array << c.shift
		end
	end

	sorted_array + b + c	

end

p merge_sort([3,222,2,5,1,7,9,4,3,4,1,44,66,77,80,-32,111])