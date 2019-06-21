require 'station'

describe Station do
  describe '#new' do
    before :each do
      @name, @zone = "limehouse", 2
    end
    it "accepts a 'name' and a 'zone' argument" do
      expect { described_class.new(@name, @zone) }.to_not raise_error
    end
    it "stores 'name' in a variable and exposes it" do
      station = described_class.new(@name, @zone)
      expect(station.name).to eq @name
    end
    it "stores 'zone' in a variable and exposes it" do
      pending("something or other")
      station = described_class.new(@name, @zone)
      expect(station.zone).to eq @zone
    end
  end
end
