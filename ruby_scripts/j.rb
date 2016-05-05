class Node
	#binary tree can have 2 children
	attr_accessor :value, :left, :right

	def initialize(value, left=nil, right=nil)
		@value = value
		@left = left
		@right = right
	end

	def insert


end

@root = nil
#input sorted array
def build_tree(arr)
	arr.shuffle!
	@root = Node.new(arr.shift)
	arr.each do |e|
		@root.
end

aa = [1,2,3,4,5,6,7,8,9]

build_tree(aa)
p aa
puts "\n\n"
p Node