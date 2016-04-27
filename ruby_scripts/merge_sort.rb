
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
	result = []
	indx_b = 0
	indx_c = 0

	while result.size < (b.size + c.size)
		if indx_b == b.size
			(result << c[indx_c..-1]).flatten!
		elsif indx_c == c.size
			(result << b[indx_b..-1]).flatten!
		elsif b[indx_b] <= c[indx_c]
			result << b[indx_b]
			indx_b += 1
		else
			result << c[indx_c]
			indx_c += 1
		end
	end

	return result		

end


p merge_sort([3,222,2,5,1,7,9,4,3,4,1,44,66,77,80,-32])