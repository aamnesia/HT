require_relative 'wagon'
class CargoWagon < Wagon
  attr_reader :volume, :occupied_volume, :volume_left, :type_name
  def initialize(number, capacity, type = :cargo)
    @type_name = "Товарный"
    @max_volume = capacity
    @occupied_volume = 0
    super
  end

  def occupy_volume(volume)
    @occupied_volume += volume
    @volume_left = @max_volume - @occupied_volume 
  end
end
