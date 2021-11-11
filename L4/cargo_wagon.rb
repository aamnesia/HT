class CargoWagon
  attr_reader :type, :number
  def initialize(number)
    @type = :cargo
    @number = number
  end
end
