class Station
  require_relative 'modules'
  include InstanceCounter

  attr_reader :station_name

  STATION_NAME_FORMAT = /^[а-я0-9]+$/i.freeze

  @@stations = []

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def trains_block(&block)
    @trains.each(&block)
  end

  def self.all
    @@stations
  end

  def coming_train(train)
    @trains << train
  end

  def staying_trains
    puts @trains.join ' '.to_s
  end

  def leaving_train(train)
    @trains.delete(train)
  end

  def each_type(type)
    each_type = @trains.find_all { |train| train.type == type }
    each_type.size
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'У станции должно быть название' if @station_name !~ STATION_NAME_FORMAT
  end
end
