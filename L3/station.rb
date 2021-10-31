class Station
  attr_reader :station

  def initialize(station)
    @station = station
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
    each_type = @trains.find_all{ |t| t.type == type }
    each_type.size
  end
end
