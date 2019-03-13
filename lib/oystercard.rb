class Oystercard

  attr_reader :balance, :journeys
  # attr_reader :entry_station,

  REQUIRED_BALANCE = 1
  MINIMUM_FARE = 2

  def initialize(journey = Journey)
    @balance = 0
    @journey = journey
    @journeys = []
  end

  def top_up(amount)
    raise max_reached_message if max_reached(amount)

    @balance += amount
  end

  def in_journey?
    @journeys.empty? ? false : !@journeys[-1].complete?
  end

  def touch_in(entry_station)
    raise min_balance_message if @balance < REQUIRED_BALANCE

    @journeys << @journey.new(entry_station)
  end

  def touch_out(exit_station)
    @journeys[-1].finish(exit_station)
    deduct(@journeys[-1].fare)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def max_reached_message
    "Unsuccessful. You have the maximum allowed amount on your card."
  end

  def max_reached(amount)
    (@balance + amount) > 90
  end

  def min_balance_message
    "Sorry, your balance is too low to start this journey."
  end

end
