
namespace :djoini do
  desc 'Load fixtures'
  task :load do |_, args|
    require_relative '../djoini'

    require File.expand_path('/config/initializers/djoini.rb')
    # To make sure configure was called if initializer wasn't foundw
    Djoini.configure {}

    _conn_info = YAML.load(File.read(Dir.pwd + '/config/database.yml'))
    Djoini::Connection.instance.establish_connection(_conn_info['postgres'])

    # Path taken from configuration
    _loader = Djoini::File.new

    if args[:type] == 'ini' || Djoini.configuration.fixtures_type == 'ini'
      _loader.load_files('ini')
    elsif args[:type] == 'json' || Djoini.configuration.fixtures_type == 'json'
      _loader.load_files('json')
    else
      _loader.load_files
    end
  end
end
