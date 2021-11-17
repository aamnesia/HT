class Station
  require_relative 'modules'
  include InstanceCounter
  attr_reader :station_name

  NAME_FORMAT = /^[а-я0-9]+$/i
  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @@stations << self
    validate!
    register_instance
  end

  @@stations = []

  def self.all
    @@stations
  end

  def coming_train(train)
    @trains << train
  end

  def staying_trains
    puts "#{@trains.join" "}"
  end

  def leaving_train(train)
    @trains.delete(train)
  end

  def each_type(type)
    each_type = @trains.find_all{ |train| train.type == type }
    each_type.size
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "У станции должно быть название" if @station_name !~ NAME_FORMAT
  end
end
