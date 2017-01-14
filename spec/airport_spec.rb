require 'airport'

describe Airport do
  subject(:airport) {described_class.new(weather_reporter, 20)}
  let(:plane) { double(:plane) }
  let(:weather_reporter) { double :weather_reporter }

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
        expect(airport).to respond_to(:land).with(1).argument
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
      expect(airport).to respond_to(:take_off).with(1).argument
    end
    it 'raises an error if plane is not at this airport' do
      allow(weather_reporter).to receive(:stormy?).and_return false
      airport_2 = Airport.new(weather_reporter, 20)
      airport_2.land(plane)
      expect{airport.take_off(plane)}.to raise_error('Cannot take off plane: the plane is not at this airport')
    end
    context 'when stormy' do
      it 'raises an error' do
        allow(weather_reporter).to receive(:stormy?).and_return true
        expect{ airport.take_off(plane) }.to raise_error('Cannot take off: weather is stormy')
      end
    end
  end


end
