class Train
  attr_reader :speed, :wagons, :current_station, :current_route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def go
   @speed = 60
  end

  def stop
    @speed = 0
  end

  def hook_wagon
    if @speed == 0
      self.wagons += 1
    end
  end

  def unhook_wagon
    if @speed == 0
      self.wagons -= 1
    end
  end

  def follow_route(route)
    @current_index = 0
    self.current_route = route
    self.current_station = current_route.route(@current_index)
  end

  def go_back
    if current_station != current_route.route.first
      @current_index -= 1
      self.current_station = current_route.route[@current_index]
  end

  def go_forward
    if current_station != current_route.route.last
      @current_index += 1
      self.current_station = current_route.route[@current_index]
  end

  def previous_station
    current_route.route(@current_index - 1)
  end

  def next_station
    current_route.route(@current_index + 1)
  end

end
