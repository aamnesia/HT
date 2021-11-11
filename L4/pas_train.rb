require_relative 'train'
class PassengerTrain < Train
  attr_reader :type_name
  def initialize(number, type = :passenger)
    @type_name = "Пассажирский"
    super
  end
end
