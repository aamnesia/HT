class Wagon
  require_relative 'modules'
  include InstanceCounter
  include Manufacturer

  attr_reader :number, :type

  WAGON_NUMBER_FORMAT = /^\d+$/.freeze

  def initialize(number, _capacity, type)
    @number = number
    @type = type
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    if @number !~ WAGON_NUMBER_FORMAT
      raise 'Номер вагона должен состоять из цифр (минимум одной)'
    end
  end
end
