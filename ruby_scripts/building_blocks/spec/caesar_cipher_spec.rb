require_relative '../caesar_cipher'

describe "caesar_cipher" do

	describe "takes string and integer parameter" do
		let(:dbl) { double }
		before { expect(dbl).to receive(:caesar_cipher).with(instance_of(String), instance_of(Fixnum)) }

		it "passes when the args match" do
			dbl.caesar_cipher("cat", 3)
		end
	end
	
	it "shifts each letter by a factor" do
		expect(caesar_cipher("cat", 3)).to eq("fdw")
	end

	it "ignores spaces" do
		expect(caesar_cipher("c a t", 3)).to eq("f d w")
	end
		
	it "maintains case" do
		expect(caesar_cipher("CaT", 3)).to eq("FdW")
	end

	it "wraps around alphabet" do
		expect(caesar_cipher("xyz", 2)).to eq("zab")
	end

	it "ignores numbers" do
		expect(caesar_cipher("cat5", 3)).to eq("fdw5")
	end

	it "accepts negative factors" do
		expect(caesar_cipher("fdw", -3)).to eq("cat")
	end

end