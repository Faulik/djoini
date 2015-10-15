require_relative 'composite'
require_relative 'record'
require_relative 'relation'

module Djoini
  # Basic abstract model to inherit
  class Base
    include Composable

    def initialize(params)
      features << Record.new(params)
    end

    def self.inherited(child_class)
      child_class.extend(ClassMethods)
    end

    # Holds method to specify table
    module ClassMethods
      include Composable

      def table_name(table_name)
        features << Relation.new(name: table_name,
                                 record_class: self)
      end
    end
  end
end
