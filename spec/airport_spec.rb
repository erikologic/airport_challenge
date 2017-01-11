require 'airport'

describe Airport do
  subject(:airport) {described_class.new(20)}
  let(:plane) { double(:plane) }

  describe '#land' do
    it 'instructs a plane to lane' do
      expect(airport).to respond_to(:land).with(1).argument
    end
    context 'when at capacity' do
      it 'raises an error' do
        20.times{ airport.land(plane) }
        expect{ airport.land(plane) }.to raise_error('Cannot land plane: airport full')
      end
    end
  end
  describe '#land' do
    it 'instructs a plane to take off' do
      expect(airport).to respond_to(:take_off).with(1).argument
    end
  end
end
