describe 'User Stories' do
  let(:airport) { Airport.new(20) }
  let(:plane) { Plane.new }

  context 'when not stormy' do
    before do
      allow(airport).to receive(:stormy?).and_return false
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
      expect{ airport.take_off(plane) }.not_to raise_error
    end

    context 'when airport is full' do
    # As an air traffic controller
    # To ensure safety
    # I want to prevent landing when the airport is full
      it 'does not allow plane to land when airport is full' do
        20.times{ airport.land(plane) }
        expect{ airport.land(plane) }.to raise_error('Cannot land plane: airport full')
      end
    end
  end



  context 'when weather is stormy' do
  # As an air traffic controller
  # To ensure safety
  # I want to prevent landing when weather is stormy
    it 'does not allow planes to land when stormy' do
      allow(airport).to receive(:stormy?).and_return true
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
end
