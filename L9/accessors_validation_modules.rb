module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        var_name = "@#{attr}".to_sym
        define_method(attr) { instance_variable_get(var_name) }
        define_method("#{attr}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @history ||= {}
          @history[attr] ||= []
          @history[attr] << value
        end
        define_method("#{attr}_history") {@history[attr]}
      end
    end
    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError unless value.class.is_a?(type)
        instance_variable_set(var_name, value)
      end
    end
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, validation_type, *arguments)
      @validations ||= []
      @validations << { name: name, type: validation_type, args: arguments }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validations.each do |validation|
        attribute = instance_variable_get("@#{validation[:name]}".to_sym)
        send validation[:type], validation[:name], attribute, validation[:args]
      end
    end

    def presence(name, attribute, _args)
      raise ArgumentError, "Аргумент #{name} не может быть пустым" if attribute.nil? || attribute.empty?
    end

    def type(name, attribute, attr_class)
      raise ArgumentError, "Аргумент #{name} не соответствует классу #{attr_class[0]}" unless attribute.is_a? attr_class[0]
    end

    def format(name, attribute, regexp)
      raise ArgumentError, "Аргумент #{name} не соответствует формату" if attribute !~ regexp[0]
    end
  end
end
