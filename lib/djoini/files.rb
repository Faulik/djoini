require_relative 'loaders/ini_loader'
require_relative 'loaders/json_loader'

module Djoini
  # Handles loading of ini and json fixtures
  class Files
    attr_accessor :path

    def initialize(fixtures_path = '')
      self.path = fixtures_path || Djoini.configuration.fixtures_folder
    end

    def load_files(type = 'mixed')
      puts "Loading #{type} files from #{path}"

      IniLoader.new(path).load_files(find_files('ini')) unless type == 'json'
      JsonLoader.new(path).load_files find_files('json') unless type == 'ini'
    end

    private

    def find_files(type)
      _files = []

      Dir.foreach(path) do |file|
        next unless File.extname(file) == ".#{type}"
        _model = file.gsub(".#{type}", '')
        _files << { model: _model, file: file }
      end

      _files
    end
  end
end
