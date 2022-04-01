# frozen_string_literal: true

require_relative '../lib/oyster_card'

describe Oystercard do
  let(:station_entered){ double(:station) }
  let(:station_exited) { double(:station) }

  it 'has a balance of zero when created' do
    expect(subject.balance).to eq 0
  end

  it 'can have the balance topped up' do
    expect(subject.top_up(5)).to eq 'Your balance is £5'
  end

  it 'has a maximum balance of £90' do
    subject.top_up(subject.max_balance)
    expect { subject.top_up(1) }.to raise_error("Top-up will exceed maximum balance of £#{subject.max_balance}")
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journey_history).to eq nil
  end

  it { is_expected.to respond_to(:in_journey?) }

  it 'will not touch in if balance is below the minimum fare' do
    expect { subject.touch_in(:station_entered) }.to raise_error('Insufficient balance')
  end

  describe 'with positive balance and touched in' do
    before(:each) do
      subject.top_up(5)
      subject.touch_in(:station_entered)
    end

    it "is 'in journey'" do
      expect(subject.in_journey?).to be true
    end

    it "is not 'in journey' if it has been touched out" do
      subject.touch_out(:station_exited)
      expect(subject.in_journey?).to be false
    end

    it 'will deduct the minimum fare when a journey is complete (touching out)' do
      expect { subject.touch_out(:station_exited) }.to change { subject.balance }.by(-1)
    end

    it 'adds to journey history after touching out' do
      subject.touch_out(:station_exited)
      expect(subject.journey_history).to eq(['Entered at: station_entered, exited at: station_exited'])
    end
  end
end
