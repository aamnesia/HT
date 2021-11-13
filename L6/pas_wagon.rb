class PassengerWagon
  include Manufacturer
  attr_reader :type, :number
  def initialize(number)
    @type = :passenger
    @number = number
  end
end
