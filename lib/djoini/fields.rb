module Djoini
  # Holds all fields and values in row\object
  class Fields
    def initialize(params)
      self.data = {}

      attributes = params.fetch(:attributes)
      values = params.fetch(:values, {})

      attributes.each { |name| data[name] = values[name.to_s] }

      build_accessors(attributes)
    end

    def clone_hash
      data.clone
    end

    private

    attr_accessor :data

    def build_accessors(attributes)
      attributes.each do |name|
        define_singleton_method(name) { data[name] }
        define_singleton_method("#{name}=") { |value| data[name] = value }
      end
    end
  end
end
