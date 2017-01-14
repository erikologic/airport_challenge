require 'weather_reporter'

class Airport
  DEFAULT_CAPACITY = 20

  def initialize(weather_reporter, capacity = 20)
    @capacity = capacity
    @weather_reporter = weather_reporter
    @planes = []
  end

  def land(plane)
    raise('Cannot land plane: airport full') if full?
    raise('Cannot land plane: weather is stormy') if stormy?
    @planes << plane
  end

  def take_off(plane)
    raise('Cannot take off: weather is stormy') if stormy?
    raise('Cannot take off plane: the plane is not at this airport') unless at_airport?(plane)
  end

  private

  def full?
    @planes.length >= @capacity
  end

  def stormy?
    @weather_reporter.stormy?
  end

  def at_airport?(plane)
    @planes.include?(plane)
  end
end
