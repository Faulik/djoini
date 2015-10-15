require 'rubygems'
require 'yaml'
require 'pry'

require_relative '../lib/djoini'

conn_info = YAML.load(File.read(File.dirname(__dir__) + '/config/database.yml'))

Djoini::Connection.instance.establish_connection(conn_info['test'])

Djoini.db.exec("CREATE TABLE IF NOT EXISTS users
  (
    id SERIAL,
    name text,
    last_name text,
    age integer,
    CONSTRAINT user_pk PRIMARY KEY (id)
  )
")

require_relative 'models/post'
require_relative 'models/user'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
