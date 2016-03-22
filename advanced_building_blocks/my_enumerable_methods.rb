module Enumerable
	def my_each
		return self unless block_given?
		for element in self
			yield(element)
		end
	end

	def my_each_with_index
		return self unless block_given?
		index = 0
		self.my_each do |element| 
			yield(element, index) 
			index += 1
		end
	end

	def my_select
		return self unless block_given?
		array = []
		self.my_each {|element| array << element if yield(element) == true}
		array
	end

	def my_all?
		if block_given? == false
			self.my_each do |e|
				if e == false || e == nil
					return false
				end
			end
			return true
		end
		self.my_each {|element| return false unless yield(element) == true}
		true
	end

	def my_any?
		if !block_given?
			self.my_each do |e|
				if e == false || e == nil
					return false
				end
			end
			return true
		end
		self.my_each {|element| return true if yield(element)}
		false
	end

	def my_none?
		if !block_given?
			self.my_each {|e| return false if e == true}
			return true
		end
		self.my_each {|element| return false if yield(element)}
		true
	end

	def my_count(arg = nil)
		count = 0
		if block_given?
			self.my_each {|e| count += 1 if yield(e)}
		elsif arg != nil
			self.my_each {|e| count += 1 if e == arg}
		else
			self.my_each {|e| count += 1}
		end
		count
	end

	def my_map
		return self unless block_given?
		array = []
		self.my_each {|element| array << yield(element)}
		array
	end

# my_map method to take either a proc, a block, or both,
# but executing the block only if both are supplied 
# (in which case it would execute both the block AND the proc).
	def my_map_mod(proc = nil)
		return self if proc == nil
		array_before_block = []
		result_if_block = []
		if proc
			self.my_each {|element| array_before_block << proc.call(element)}
		end
		if block_given?
			array_before_block.my_each {|e| result_if_block << yield(e)}
			return result_if_block
		end
		array_before_block
	end

# working with symbols does not work like it would with normal #inject
	def my_inject(arg = nil)
		arg = self[0] if arg.nil?
		accumulator = arg
		if block_given?
			self.my_each {|element| accumulator = yield(accumulator, element)}
		end
		accumulator
	end
end

def multiply_els(array)
	array.my_inject(1) {|product, element| product = product * element}
end