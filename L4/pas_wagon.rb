class PassengerWagon
  attr_reader :type, :number
  def initialize(number)
    @type = :passenger
    @number = number
  end
end
