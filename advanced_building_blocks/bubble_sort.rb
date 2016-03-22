def bubble_sort(numArray)
	sorted = false
	swaps = 0
	passes = 0
	n = numArray.length
	until sorted
	    for i in 1...(n - passes)
	        if numArray[i] < numArray[i-1]
	        	numArray[i], numArray[i-1] = numArray[i-1], numArray[i]
	        	swaps += 1
	        end
	    end
	    sorted = true if swaps == 0
	    swaps = 0
	    passes += 1
	end
	numArray
end

p bubble_sort([5,4,1,3,2])
bubble_sort([9,2,4,1,5,2,2,1,3,9,4,6,0,12,3,5,7,1,8])