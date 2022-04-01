require_relative '../lib/journey'

describe Journey do
  let(:station_entered) { double(:station_entered) }
  let(:station_exited) { double(:station_exited) }
  let(:journey) { Journey.new(station_entered) }
  context "#creation" do
    it "has a start point" do
      expect(journey.entry_station).to eq station_entered
    end
  end

  context "#finish" do
    it "gives it an exit station" do
      journey.finish(station_exited)
      expect(journey.exit_station).to eq station_exited
    end
  end

  context "#fare" do
    it "returns the minimum fare" do
      expect(journey.fare).to eq 1
    end
  end

  context "#complete?" do
    it "checks the journey as incomplete" do
      expect(journey.complete?).to eq false
    end
  end
end