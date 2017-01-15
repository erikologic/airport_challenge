class Plane
  def initialize
    @flying = true
  end

  def take_off
    raise 'Cannot takeoff: plane already flying' if @flying
  end

  def airport
    raise 'Cannot be at an airport: plane already flying' if @flying
    @airport
  end

  def land(airport)
    raise 'Cannot land plane: plane already landed' unless @flying
    @flying = false
    @airport = airport
  end
end
