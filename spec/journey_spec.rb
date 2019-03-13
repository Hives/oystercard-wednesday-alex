require 'journey'

describe Journey do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#new' do
    it "raises an error if called with no argument" do
      expect { described_class.new }.to raise_error ArgumentError
    end
    it "accepts a 'station' argument" do
      expect { described_class.new(entry_station) }.not_to raise_error
    end
    it "records the entry station" do
      @journey = Journey.new(entry_station)
      expect(@journey.entry_station).to eq entry_station
    end
  end

  describe '#finish' do
    before :each do
      @journey = Journey.new(entry_station)
    end
    it "raises an error if called with no argument" do
      expect { @journey.finish }.to raise_error ArgumentError
    end
    it "accepts a 'station' argument" do
      expect { @journey.finish(exit_station) }.not_to raise_error
    end
    it "records the exit station" do
      @journey.finish(exit_station)
      expect(@journey.exit_station).to eq exit_station
    end
    # it 'raises an error if journey is already complete' do
    # end
  end 

  describe '#complete?' do
    before :each do
      @journey = Journey.new(entry_station)
    end
    it 'reports incomplete journey' do
      expect(@journey).not_to be_complete
    end 
    it "reports/mark complete journey" do
      @journey.finish(exit_station)
      expect(@journey).to be_complete
    end
  end

  describe '#fare' do
    before :each do
      @journey = Journey.new(entry_station)
    end
    context 'journey is not complete' do
      it 'returns the penalty fare' do
        expect(@journey.fare).to eq 6
      end
    end
    context 'journey is complete' do
      it 'returns the minimum fare (for the moment)' do
        @journey.finish(exit_station)
        expect(@journey.fare).to eq 2
      end
    end
  end

end
