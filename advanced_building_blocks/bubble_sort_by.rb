def bubble_sort_by(array)
	sorted = false
	swaps = 0
	passes = 0
	n = array.length
	until sorted
	    for i in 1...(n - passes)
	        if yield(array[i-1],array[i]) > 0
	        	array[i], array[i-1] = array[i-1], array[i]
	        	swaps += 1
	        end
	    end
	    sorted = true if swaps == 0
	    swaps = 0
	    passes += 1
	end
	array
end


bubble_sort_by(["hello","hi","hi there", "sup", "yo"]) do |left,right|
	left.length - right.length
end