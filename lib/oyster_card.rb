# frozen_string_literal: true

require_relative './journey'

class Oystercard
  attr_reader :balance, :max_balance, :entry_station, :list_of_journeys 

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @max_balance = MAXIMUM_BALANCE
    @list_of_journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Top-up will exceed maximum balance of £#{@max_balance}" if exceed_limit?(amount)

    @balance += amount
    "Your balance is £#{@balance}"
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_in(station)
    raise 'Insufficient balance' if insufficient_balance?
    @current_journey = Journey.new(station)
  end

  def touch_out(exit_station)
    @current_journey.finish(exit_station)
    @list_of_journeys.push( @current_journey )
    deduct(MINIMUM_BALANCE)
    'Journey complete.'
    @current_journey = nil
  end

  def journey_history
    journey_history = []
    @list_of_journeys.each do |journey|
      journey_history.push("Entered at: #{journey.entry_station}, exited at: #{journey.exit_station}")
    end
    journey_history unless journey_history.empty?
  end

  private

  def deduct(amount)
    @balance -= amount
    "Your balance is now £#{@balance}"
  end

  def exceed_limit?(amount)
    @balance + amount > @max_balance
  end

  def insufficient_balance?
    @balance < MINIMUM_BALANCE
  end
end
