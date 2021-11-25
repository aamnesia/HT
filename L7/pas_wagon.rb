require_relative 'wagon'
class PassengerWagon < Wagon
  attr_reader :number_of_seats, :taken_seats, :free_seats, :type_name
  def initialize(number, capacity, type = :passenger)
    @type_name = "Пассажирский"
    @number_of_seats = capacity
    @taken_seats = 0
    super
  end

  def take_seat
    @taken_seats += 1
    @free_seats = @number_of_seats - @taken_seats
  end
end
