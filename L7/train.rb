class Train
  require_relative 'modules'
  include Manufacturer, InstanceCounter
  attr_accessor :speed, :wagons
  attr_reader :current_station, :current_route, :type, :number

  NUMBER_FORMAT = /\A[а-я0-9]{3}-?[а-я0-9]{2}\z/i
  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    @@trains[@number] = self
    register_instance
  end

  def wagons_block
    @wagons.each { |wagon| yield(wagon)}
  end

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
    end
  end

  def unhook_wagon(wagon)
    if @speed == 0
      @wagons.delete(wagon)
    end
  end

  def follow_route(route)
    @current_route = route
    @current_station = @current_route.stations[0]
    @current_station.coming_train(self)
  end

  def go_back
    if self.previous_station
      @current_station.leaving_train(self)
      @current_station = self.previous_station
      @current_station.coming_train(self)
    end
  end

  def go_forward
    if self.next_station
      @current_station.leaving_train(self)
      @current_station = self.next_station
      @current_station.coming_train(self)
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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Недопустимый формат номера поезда" if @number !~ NUMBER_FORMAT
  end
end
