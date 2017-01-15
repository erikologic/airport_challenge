require 'plane'

describe Plane do
  subject(:plane){ described_class.new }
  let(:airport){double :airport}

  describe '#take_off' do
    it { is_expected.to respond_to :take_off }

    it 'raises an error if already flying' do
      expect{ plane.take_off }.to raise_error 'Cannot takeoff: plane already flying'
    end

    # it 'will change the value of the flying method' do
    #
    # end
  end

  describe '#airport' do
    it 'stores the airport the plane landed at' do
      plane.land(airport)
      expect(plane.airport).to eq airport
    end

    it 'raises an error if already flying' do
      expect{ plane.airport }.to raise_error 'Cannot be at an airport: plane already flying'
    end

  end

  describe '#land' do
    it { is_expected.to respond_to :land }

    it 'raises an error if already landed' do
      plane.land(airport)
      expect{ plane.land(airport) }.to raise_error 'Cannot land plane: plane already landed'
    end


  end
end
