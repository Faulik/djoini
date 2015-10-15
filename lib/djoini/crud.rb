module Djoini
  # Holds basic crud operaions. Workds like wrapper above Table.
  class Crud
    def initialize(relation)
      self.relation = relation
    end

    def create(values)
      id = table.insert(values)[0]['id'].to_i

      find(id)
    end

    def update(id, values)
      table.update(where: { table.primary_key => id },
                   fields: values)
    end

    def find(id)
      values = table.where(table.primary_key => id).first

      return nil unless values

      relation.new_record(values)
    end

    def where(params)
      rows = table.where(params)

      rows.map { |values| relation.new_record(values) }
    end

    def destroy(id)
      table.delete(table.primary_key => id)
    end

    def all
      table.all.map { |values| relation.new_record(values) }
    end

    def delete_all
      table.delete_all
    end

    private

    attr_accessor :relation

    def table
      relation.table
    end
  end
end
