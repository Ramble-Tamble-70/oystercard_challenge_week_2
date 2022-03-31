# frozen_string_literal: true

class Station
  attr_reader :station_name, :zone

  def initialize(station_name, zone)
    @station_name = station_name
    @zone = zone
  end
end
