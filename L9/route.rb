class Route
  require_relative 'modules'
  include InstanceCounter

  attr_reader :stations, :route_name

  def initialize(first_station, last_station)
    @route_name = "#{first_station.station_name} -- #{last_station.station_name}"
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.include?(station)
  end

  def print_route
    @stations.each { |station| puts station }
  end
end
