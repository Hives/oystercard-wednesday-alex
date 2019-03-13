require 'Oystercard'
describe Oystercard do
  before :each do
    @entry_station = double(:entry_station)
    @exit_station = double(:exit_station)
  end

  it 'has a balance' do
    expect(subject.balance).to eq 0
  end

  # it 'has no entry station when initialised' do
  #   expect(subject.entry_station).to be_nil
  # end

  describe '#top_up' do
    before :each do
      subject.top_up(90)
    end

    it 'is able to top-up' do
      expect(subject.balance).to eq 90
    end

    it 'raises error when topping up to more than 90' do
      expect { subject.top_up(1) }.to raise_error(
        "Unsuccessful. You have the maximum allowed amount on your card."
      )
    end
  end

  describe '#in_journey' do
    it 'returns false when first initialised' do
      expect(subject).not_to be_in_journey
    end
    context 'after touching in' do
      before :each do
        subject.top_up(20)
        subject.touch_in(@entry_station)
      end
      it 'returns true' do
        expect(subject).to be_in_journey
      end
      context 'and after touching out again' do
        before :each do
          subject.touch_out(@exit_station)
        end
        it 'returns false' do
          expect(subject).not_to be_in_journey
        end
      end
    end
  end
  
  describe '#touch_in' do
    it 'sets in_journey status to true' do
      subject.top_up(90)
      subject.touch_in(@entry_station)
      expect(subject).to be_in_journey
    end
  
    it 'records the entry station' do
      subject.top_up(10)
      subject.touch_in(@entry_station)
      expect(subject.journeys[-1].entry_station).to eq @entry_station
    end

    it 'raises an error when the balance is less than £1' do
      expect { subject.touch_in(@entry_station) }.to raise_error "Sorry, your balance is too low to start this journey."
    end
  end

  describe '#touch_out' do
    before :each do
      subject.top_up(10)
      subject.touch_in(@entry_station)    
    end

    it 'sets in_journey status to false' do
      subject.touch_out(@exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'records the exit station' do
      subject.touch_out(@exit_station)
      expect(subject.journeys[-1].exit_station).to eq @exit_station
    end

    it 'deducts the correct amount from my card for the journey' do
      minimum_fare = described_class::MINIMUM_FARE
      expect { subject.touch_out(@exit_station) }.to change { subject.balance }.by(-minimum_fare)
    end
  end

  describe '#journeys' do
    it "returns an empty array at first" do
      expect(subject.journeys).to eq []
    end
    context "after touching in and out" do
      before :each do
        subject.top_up(20)
        subject.touch_in(@entry_station)
        subject.touch_out(@exit_station)
      end
      it "contains a complete journey" do
        expect(subject.journeys[-1]).to be_complete
      end
    end
  end
end
