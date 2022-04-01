require_relative './station'

class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station_entered)
    @entry_station = station_entered
    @exit_station = nil
  end

  def finish(station_exited)
    @exit_station = station_exited
  end

  def fare
    return PENALTY_FARE if @exit_station == nil || @entry_station == nil
    MINIMUM_FARE
  end

  def complete?
    @exit_station != nil
  end
end
