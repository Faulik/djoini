module Djoini
  # Holds basic table info and low-level operations
  class Table
    attr_reader :primary_key, :name, :columns

    def initialize(params)
      self.name = params.fetch(:name)
      self.db = Djoini.db
      self.columns = {}

      parse_table_info
    end

    def insert(params)
      check_keys params

      _field_names = params.keys.join(', ')

      _values = params.values.map { |a| %('#{a}') }.join(', ')

      db.exec "insert into #{name} (#{_field_names}) values (#{_values})
               returning #{primary_key}"
    end

    def update(params)
      check_keys params[:fields]

      db.exec "update #{name}
               set #{bind_vars(params[:fields], ', ')}
               where #{bind_vars(params[:where], ' AND ')}"
    end

    def where(params)
      check_keys params

      db.exec "select * from #{name}
               where #{bind_vars(params, ' AND ')}"
    end

    def all
      db.exec "select * from #{name}"
    end

    def delete(params)
      db.exec "delete from #{name} where #{bind_vars(params, ', ')}"
    end

    def delete_all
      db.exec "delete from #{name}"
    end

    private

    attr_accessor :db
    attr_writer :primary_key, :name, :columns

    def check_keys(params)
      fail unless params.keys.all? { |e| columns.key?(e.to_s) }
    end

    def bind_vars(params, separator)
      check_keys params

      params.map { |k, v| "#{k} = #{evaluate_value(v)}" }.join(separator)
    end

    def evaluate_value(value)
      return "'#{value}'" unless value.to_s.empty?
      'NULL'
    end

    def parse_table_info
      _raw_data = db.exec("SELECT *
                           FROM information_schema.columns
                           WHERE table_schema = 'public'
                           AND table_name   = '#{name}'")
      _raw_data.each do |row|
        column_name = row['column_name']

        self.primary_key ||= column_name

        columns[column_name] = { type: row['data_type'] }
      end
    end
  end
end
