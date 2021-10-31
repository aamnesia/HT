class Route
  attr_reader :route

  def initialize(first_station, last_station)
    @route = [first_station, last_station]
  end

  def add_station(station)
    @route.insert(-2, station)
  end

  def delete_station(station)
    if @route.include?(station)
      @route.delete(station)
    end
  end

  def print_route
    @route.each { |station| puts station}
  end
end
