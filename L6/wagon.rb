class Wagon
  require_relative 'modules'
  include Manufacturer, InstanceCounter
  attr_reader :number, :type

  NUMBER_FORMAT = /^\d+$/

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Номер вагона должен состоять из цифр (минимум одной)" if @number !~ NUMBER_FORMAT
  end
end
