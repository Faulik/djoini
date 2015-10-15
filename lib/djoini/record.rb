require_relative 'composite'
require_relative 'fields'

module Djoini
  # Holds creation and destruction of model, his fields
  class Record
    include Composable

    def initialize(params)
      self.key = params.fetch(:key, nil)
      self.relation = params.fetch(:relation)

      features << Fields.new(values: params.fetch(:values, {}),
                             attributes: relation.attributes)
    end

    def save
      if key
        relation.update(key, clone_hash)
      else
        relation.create(clone_hash)
      end
    end

    def destroy
      relation.destroy(key)
    end

    private

    attr_accessor :relation, :key
  end
end
