
#returns fibonacci sequense starting with 0,1,1
def fibs(n)
	sequence = [0,1]
	if n > 2
		(n-2).times do
			sequence << sequence[-2] + sequence[-1]
		end
	end
	sequence.join(",")
end
puts fibs(15)

#returns just nth member of the fibonacci sequence
#using a recursive method
#does not include leading 0 as a member
def fibs_rec(n)
	return n if n <= 1
	fibs_rec(n-1) + fibs_rec(n-2)
end
puts fibs_rec(15)

#returns the full modern usage fibonacci sequence to the nth member
def fibs_rec2(n, sequence=[0,1])
	return sequence if n <= 1
	fibs_rec2(n, (sequence << (sequence[-2] + sequence[-1]))) unless sequence.size == n
	sequence.join(",")
end
puts fibs_rec2(15)