class Plane
  def take_off
    raise 'Cannot takeoff: plane already flying'
  end

  def airport
    raise 'Cannot be at an airport: plane already flying'
  end

end
