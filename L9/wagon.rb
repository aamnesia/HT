class Wagon
  require_relative 'modules'
  require_relative 'accessors_validation_modules'
  include InstanceCounter, Manufacturer, Validation

  attr_reader :number, :type

  WAGON_NUMBER_FORMAT = /^\d+$/.freeze

  validate :number, :type, Fixnum

  def initialize(number, _capacity, type)
    validate!
    @number = number
    @type = type
    register_instance
  end
end
