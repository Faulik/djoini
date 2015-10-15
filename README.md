# Djoini

DJsOnINI is a implementation of ActiveModel pattern and a fixture loader for json and ini formats. It implement's only a little part of pattern, so isn't usable in serious applications.

Thing's that are implemented:
- Djoini::Base class to inherit from
- Basic crud operations like
  - create
  - update
  - find
  - where
  - destroy
  - all
  - delete_all
- Connection to the postgres database, via pg driver
- Rake task to load fixtures
- Config files via `Djoini.config` and .yaml for database


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'djoini'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install djoini

## Usage

**Important**
Make appropriate tables or use other gem to create migrations. This gem doesn't handle migrations only mapping and loading.

Also you need to create database.yml in your `PWD/config/` folder with  at least this content to use local db with specified credentials.

```yaml
postgres:
  adapter: postgresql
  db_name: djoini_test
  username: ruby
  password: noway
```

Example for fixtures can be found in tests.

### Model usage:

```ruby
# Model that will produce Post's object
class Post < Djoini::Base # Inherit from Base class to use the power of ActiveRecord
  table_name :posts # Explicitly specify table name to be mapped to, scheme    
                    # counted as 'public'.
end
```

After that just use them like you normaly would with ActiveRecord:

```ruby
user = User.create(name: 'Jack', last_name: 'Daniels')
user.name = 'Nansy'
user.last_name = 'Drew'
user.age = 30
user.save

user.destroy
```

For more examples see tests.

### Rake task usage

Example app can be found at https://github.com/Faulik/djoini_example .

**Important**
- With `mixed` loading .ini files will be loaded first.
- All file names must be named after coresponding tables, not models.

To add task to rake append this code in `Rakefile`:

```ruby
spec = Gem::Specification.find_by_name 'djoini'
load "#{spec.gem_dir}/lib/tasks/load.rake"
```

To load fixtures all fixtures(both ini and json) from default directory(`PWD/db/fixtures`):

```
bundle exec rake djoini:load
```

To load only `ini` fixtures, overrides options in config file:

```
bundle exec rake djoini:load[ini]
```

To specify location of fixtures use configuration module:

```ruby
Djoini.configure do |config|
  config.fixtures_folder = 'path'
  config.fixtures_type = 'ini/json/mixed' 
end
```
Djoini will try to find `PWD/config/initializers/djoini.rb` and load it.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/faullik/djoini. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
