require 'multi_json'

module Djoini
  # Handles load of ini type files.
  class JsonLoader
    attr_reader :path

    def initialize(path)
      self.path = path
    end

    # Accepts array of [ { model: name, file: File },.. ]
    def load_files(array)
      array.each do |fixture|
        _model_table = Table.new(name: fixture[:model])

        _data = parse_json(fixture[:file])
        
        _data.each do |obj|
          _model_table.insert(obj)
        end
      end
    end

    private

    attr_writer :path

    def parse_json(file)
      MultiJson.load(File.read(File.join(path, file)))
    end
  end
end
