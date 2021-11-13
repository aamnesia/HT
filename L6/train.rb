class Train
  require_relative 'modules'
  include Manufacturer
  include InstanceCounter
  attr_accessor :speed, :wagons
  attr_reader :current_station, :current_route, :type, :number

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @@trains[@number] = self
    register_instance
  end

  @@trains = []

  def find(number)
    @@trains[number]
  end

  def go
   @speed = 60
  end

  def stop
    @speed = 0
  end

  def hook_wagon(wagon)
    if @speed == 0 && @type == wagon.type
      @wagons << wagon
      puts "Вагон прицеплен!"
    end
  end

  def unhook_wagon(wagon)
    if @speed == 0
      @wagons.delete(wagon)
      puts "Вагон отцеплен!"
    end
  end

  def follow_route(route)
    @current_route = route
    @current_station = @current_route.stations[0]
  end

  def go_back
    if self.previous_station
      @current_station = self.previous_station
    end
  end

  def go_forward
    if self.next_station
      @current_station = self.next_station
    end
  end

  def previous_station
    if @current_station != @current_route.stations.first
      current_index = @current_route.stations.find_index(@current_station)
      @current_route.stations[current_index - 1]
    end
  end

  def next_station
    if @current_station != @current_route.stations.last
      current_index = @current_route.stations.find_index(@current_station)
      @current_route.stations[current_index + 1]
    end
  end

end
