# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type_name

  def initialize(number, type = :cargo)
    @type_name = 'Товарный'
    super
  end
end
