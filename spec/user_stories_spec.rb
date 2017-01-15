### https://www.youtube.com/watch?v=Vg0cFVLH_EM&96m00s

require 'weather_reporter'
require 'airport'
require 'plane'

describe 'User Stories' do
  let(:airport) { Airport.new(weather_reporter, 20) }
  let(:plane) { Plane.new }
  let(:weather_reporter) { WeatherReporter.new }

  context 'when not stormy' do
    before do
      allow(weather_reporter).to receive(:stormy?).and_return false
    end
    #  As an air traffic controller
    # So I can get passengers to a destination
    # I want to instruct a plane to land at an airport and confirm that it has landed
    it 'so planes land at airports, instruct a plane to land' do
      expect{ airport.land(plane) }.not_to raise_error
    end

    # As an air traffic controller
    # So I can get passengers on the way to their destination
    # I want to instruct a plane to take off from an airport and confirm that it is no longer in the airport
    it 'so planes take off from airports, instruct a plane to take off' do
      airport.land(plane)
      expect{ airport.take_off(plane) }.not_to raise_error
    end

    # I want planes to take off from the the airport they are at
    it 'take off planes only from the airport they are at' do
        airport_2 = Airport.new(WeatherReporter.new, 20)
        airport_2.land(plane)
        expect{ airport.take_off(plane) }.to raise_error('Cannot take off plane: the plane is not at this airport')
    end

    # I want to ensure a plane cannot take off and be in an airport
    it 'flying planes cannot take off' do
      expect{ plane.take_off }.to raise_error 'Cannot takeoff: plane already flying'
    end

    it 'flying planes cannot be at an airport' do
      expect{ plane.airport }.to raise_error 'Cannot be at an airport: plane already flying'
    end

    # I want to be sure the system is consistent
    # a plane not flying cannot take off and must be in an airport
    it 'not flying plane cannot land' do
      airport.land(plane)
      expect{ plane.land(airport) }.to raise_error 'Cannot land plane: plane already landed'

    end

    it 'not flying planes must be in an airport' do
      airport.land(plane)
      expect(plane.airport).to eq airport
    end

    context 'when airport is full' do
    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when the airport is full
      it 'does not allow plane to land when airport is full' do
        20.times{ airport.land(Plane.new) }
        expect{ airport.land(plane) }.to raise_error('Cannot land plane: airport full')
      end
    end
  end



  context 'when weather is stormy' do
  # As an air traffic controller
  # To ensure safety
  # I want to prevent landing when weather is stormy
    it 'does not allow planes to land when stormy' do
      allow(weather_reporter).to receive(:stormy?).and_return true
      expect{ airport.land(plane) }.to raise_error('Cannot land plane: weather is stormy')
    end
    # As an air traffic controller
    # To ensure safety
    # I want to prevent takeoff when weather is stormy
    it 'does not allow planes to take off when stormy' do
      allow(airport).to receive(:stormy?).and_return true
      expect{ airport.take_off(plane) }.to raise_error('Cannot take off: weather is stormy')
    end
  end

  it 'airports has a default capacity' do
      allow(weather_reporter).to receive(:stormy?).and_return false
      defeaults_airport = Airport.new(weather_reporter)
      Airport::DEFAULT_CAPACITY.times {airport.land(Plane.new)}
      expect{ airport.land(plane) }.to raise_error('Cannot land plane: airport full')
  end
end
