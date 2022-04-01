# frozen_string_literal: true

require_relative '../lib/oyster_card'

class Oystercard
  attr_reader :balance, :max_balance, :entry_station, :list_of_journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @max_balance = MAXIMUM_BALANCE
    @entry_station = nil
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "Top-up will exceed maximum balance of £#{@max_balance}" if exceed_limit?(amount)

    @balance += amount
    "Your balance is £#{@balance}"
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise 'Insufficient balance' if insufficient_balance?
    @entry_station = station

  end

  def touch_out(exit_station)
    @list_of_journeys.push({ entry: @entry_station, exit: exit_station })
    @entry_station = nil
    deduct(MINIMUM_BALANCE)
    'Journey complete.'
  end

  def journey_history
    journey_history = []
    @list_of_journeys.each do |journey|
      journey_history.push("Entered at: #{journey[:entry]}, exited at: #{journey[:exit]}")
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
