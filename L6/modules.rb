module Manufacturer
  attr_accessor :manufacturer
end

module  InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstaceMethods
  end

module ClassMethods
  def instances
    @instances
  end

  def counter_up
    @instances ||= 0
    @instances += 1
  end
end

module InstanceMethods
  protected
  def register_instance
    self.class.counter_up
  end
end
