module Djoini
  # Handles array for dynamic attributes and the module to include
  module Composable
    def features
      @__features__ ||= Composite.new
    end

    def respond_to_missing?(method, *_array)
      features.reveives?(method)
    end

    def method_missing(method, *array, &block)
      features.dispatch(method, *array, &block)
    end
  end

  # Handles dynamic attributes of the model
  class Composite
    def initialize
      self.recievers = []
    end

    def <<(method)
      recievers.push(method)
    end

    def reveives?(method)
      reciever(method)
    end

    def dispatch(method, *array, &block)
      obj = reciever(method)

      fail NoMethodError, "No component implements #{method}" unless obj

      obj.send(method, *array, &block)
    end

    private

    def reciever(method)
      recievers.find { |el| el.respond_to?(method) }
    end

    attr_accessor :recievers
  end
end
