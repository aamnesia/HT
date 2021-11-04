class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if @stations.include?(station)
      @stations.delete(station)
    end
  end

  def print_route
    @stations.each { |station| puts station}
  end
end
