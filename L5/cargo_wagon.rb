class CargoWagon
  include Manufacturer
  attr_reader :type, :number
  def initialize(number)
    @type = :cargo
    @number = number
  end
end
