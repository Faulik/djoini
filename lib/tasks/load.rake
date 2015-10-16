
namespace :djoini do
  desc 'Load fixtures'
  task :load, [:type] do |_, args|
    require_relative '../djoini'

    load_configuration

    _loader = Djoini::Files.new

    _type = args[:type] || Djoini.configuration.fixtures_type

    puts "Loading #{_type} files from #{Djoini.configuration.fixtures_folder}"

    _loader.load_files(_type)
  end

  def load_configuration
    _config_path = File.join(Dir.pwd, '/config/initializers/djoini.rb')

    require _config_path if File.file?(_config_path)
    # To make sure configure was called if initializer wasn't found
    Djoini.configure {}
  end
end
