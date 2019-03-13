class Journey
  attr_reader :entry_station
  attr_reader :exit_station

  MINFARE = 2
  PENALTY = 6

  def initialize(entry_station)
    @entry_station = entry_station 

  end 

  def finish(exit_station) 
    @exit_station = exit_station
    self
  end

  def complete?
    !@exit_station.nil?
  end

  def fare
    complete? ? MINFARE : PENALTY
  end 

end
