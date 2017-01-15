require 'airport'

describe Airport do
  subject(:airport) {described_class.new(weather_reporter, 20)}
  let(:plane) { double :plane, land: nil, take_off: nil }
  let(:weather_reporter) { double :weather_reporter, stormy?: false }

  context 'defaults' do
    subject(:default_airport){described_class.new(weather_reporter)}

    it 'has a default capacity' do
      # default_airport = described_class.new(weather_reporter)
      allow(weather_reporter).to receive(:stormy?).and_return false
      described_class::DEFAULT_CAPACITY.times {default_airport.land(plane)}
      expect{ default_airport.land(plane) }.to raise_error('Cannot land plane: airport full')
    end
  end

  describe '#land' do
    context 'when not stormy' do
      before do
        allow(weather_reporter).to receive(:stormy?).and_return false
      end
      it 'instructs a plane to land' do
        expect(plane).to receive(:land)
        airport.land(plane)
      end
      context 'when full' do
        it 'raises an error' do
          20.times{ airport.land(plane) }
          expect{ airport.land(plane) }.to raise_error('Cannot land plane: airport full')
        end
      end
    end
    context 'when stormy' do
      it 'raises an error' do
        allow(weather_reporter).to receive(:stormy?).and_return true
        expect{ airport.land(plane) }.to raise_error('Cannot land plane: weather is stormy')
      end
    end
  end

  describe '#take_off' do
    it 'instructs a plane to take off' do
      airport.land(plane)
      expect(plane).to receive(:take_off)
      airport.take_off(plane)
    end
    it 'raises an error if plane is not at this airport' do
      allow(weather_reporter).to receive(:stormy?).and_return false
      airport_2 = Airport.new(weather_reporter, 20)
      airport_2.land(plane)
      expect{airport.take_off(plane)}.to raise_error('Cannot take off plane: the plane is not at this airport')
    end
    it 'returns the plane that took_off' do
      allow(weather_reporter).to receive(:stormy?).and_return false
      airport.land(plane)
      expect(airport.take_off(plane)).to eq plane
    end
    context 'when stormy' do
      it 'raises an error' do
        allow(weather_reporter).to receive(:stormy?).and_return true
        expect{ airport.take_off(plane) }.to raise_error('Cannot take off: weather is stormy')
      end
    end
  end

  describe '#planes' do
    it 'returns planes that are at the airport' do
      airport.land(plane)
      expect(airport.planes).to include plane
    end

    it 'does not return planes that have taken off' do
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.planes).not_to include plane
    end
  end
end
