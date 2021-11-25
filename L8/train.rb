class Train
  require_relative 'modules'
  include InstanceCounter
  include Manufacturer

  attr_accessor :speed, :wagons
  attr_reader :current_station, :current_route, :type, :number

  TRAIN_NUMBER_FORMAT = /\A[а-я0-9]{3}-?[а-я0-9]{2}\z/i.freeze

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

  def wagons_block(&block)
    @wagons.each(&block)
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
    @wagons << wagon if @speed.zero? && @type == wagon.type
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
  end

  def follow_route(route)
    @current_route = route
    @current_station = @current_route.stations.first
    @current_station.coming_train(self)
  end

  def go_back
    if previous_station
      @current_station.leaving_train(self)
      @current_station = previous_station
      @current_station.coming_train(self)
    end
  end

  def go_forward
    if next_station
      @current_station.leaving_train(self)
      @current_station = next_station
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
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Недопустимый формат номера поезда' if @number !~ TRAIN_NUMBER_FORMAT
  end
end
