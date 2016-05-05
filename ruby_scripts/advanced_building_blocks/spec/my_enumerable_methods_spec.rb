require_relative "../my_enumerable_methods"

describe Enumerable do
	let(:arr_num) {[3,6,9]}
	let(:arr_str) {["damn", "you're", "fine"]}
	let(:arr_empty) {[]}

	describe "#my_each" do
		it "applies block to each element in array" do
			arr_num.my_each {|e| arr_empty << e}
			expect(arr_empty).to eq(arr_num)
		end

		it "returns self if no block given" do
			expect(arr_num.my_each).to eq([3,6,9])
		end
	end

	describe "#my_select" do
		it "returns new array of elements if true in block" do
			arr = arr_num.my_select { |e| e < 8 }
			expect(arr).to eq([3,6])
		end
	end

	describe "#my_all?" do
		it "returns true if all elements pass block" do
			arr_empty = arr_num.my_all?{|e| e < 10}
			expect(arr_empty).to be true
		end

		it "returns false when not all elements pass" do
			arr = arr_num.my_all?{|e| e < 8}
			expect(arr).to be false
		end
	end

	describe "#my_any?" do
		it "returns true if any element passes block" do
			arr_empty = arr_str.my_any? {|e| e == "fine" }
			expect(arr_empty).to be true
		end
	end

	describe "#my_map" do
		it "returns new array after iterating each element" do
			arr_empty = arr_str.my_map{|e| e + "OOO"}
			expect(arr_empty).to eq(["damnOOO", "you'reOOO", "fineOOO"])
		end
	end

end










