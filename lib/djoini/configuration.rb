# Configuration provider
# Djoini.configure do |config|
#   config.key1 = value
#   config.key2 = value
# end
module Djoini
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Main configuration for app
  class Configuration
    # Fixtures config
    attr_accessor :fixtures_folder
    attr_accessor :fixtures_type

    def initialize
      self.fixtures_folder = File.join(Dir.pwd, '/db/fixtures')
      self.fixtures_type = 'mixed'
    end
  end
end
