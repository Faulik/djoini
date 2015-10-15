require_relative 'composite'
require_relative 'crud'
require_relative 'table'

module Djoini
  # Hold creation of new records(rows\objects)
  class Relation
    include Composable

    def initialize(params)
      self.table = Table.new(name: params.fetch(:name))

      self.record_class = params.fetch(:record_class)

      features << Crud.new(self)
    end

    attr_reader :table

    def attributes
      table.columns.keys
    end

    def new_record(values)
      record_class.new(relation: self,
                       values: values,
                       key: values[table.primary_key])
    end

    private

    attr_accessor :record_class
    attr_writer :table
  end
end
