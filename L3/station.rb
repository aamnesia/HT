class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
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
end
