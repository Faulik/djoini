require 'iniparse'

module Djoini
  # Handles load of ini type files.
  class IniLoader
    attr_reader :path

    def initialize(path)
      self.path = path
    end

    # Accepts array of [ { model: name, file: File },.. ]
    def load_files(array)
      array.each do |fixture|
        _model_table = Table.new(name: fixture[:model])

        _data = parse_ini(fixture[:file])

        _data.to_hash.each do |_, obj|
          _model_table.insert(obj)
        end
      end
    end

    private

    attr_writer :path

    def parse_ini(file)
      IniParse.parse(File.read(File.join(path, file)))
    end
  end
end
