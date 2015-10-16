require 'singleton'
require 'pg'
require 'yaml'

# Holds connection singleton class
module Djoini
  def self.db
    Connection.instance.conn
  end

  # Class to manage db connetion to postgres
  class Connection
    include Singleton

    def conn
      db || load_database
    end

    def establish_connection(params)
      _adapter = params.fetch('adapter', 'postgres')
      _username = params.fetch('username')
      _password = params.fetch('password', '')
      _host = params.fetch('host', 'localhost')
      _port = params.fetch('port', '5432')
      _db_name = params.fetch('db_name')

      self.db = PG.connect("#{_adapter}://#{_username}:#{_password}@#{_host}:#{_port}/#{_db_name}")
    end

    def self.load_database(db_name = 'postgres')
      _db_config_path = File.join(Dir.pwd, '/config/database.yml')

      fail unless File.file?(_db_config_path)

      _conn_config = YAML.load(File.read(_db_config_path))
      Djoini::Connection.instance.establish_connection(_conn_config[db_name])
    end

    private

    attr_accessor :db
  end
end
