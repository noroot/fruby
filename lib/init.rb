# frozen_string_literal: true

# lib/init.rb

db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'database.yml')

if File.exist?(db_config_file)
  config = YAML.safe_load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].sort.each { |file| require file }

Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'app', 'db', 'migrations')) if DB

Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].sort.each { |file| require file }

ROUTES = YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))
