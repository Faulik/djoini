require 'singleton'
require 'pg'

# Holds connection singleton class
module Djoini
  def self.db
    Connection.instance.conn
  end

  # Class to manage db connetion to postgres
  class Connection
    include Singleton

    attr_reader :conn

    def establish_connection(params)
      _adapter = params.fetch('adapter', 'postgres')
      _username = params.fetch('username')
      _password = params.fetch('password', '')
      _host = params.fetch('host', 'localhost')
      _port = params.fetch('port', '5432')
      _db_name = params.fetch('db_name')

      @conn = PG.connect("#{_adapter}://#{_username}:#{_password}@#{_host}:#{_port}/#{_db_name}")
    end

    private

    attr_writer :conn
  end
end
