require_relative '../app/controllers/application_controller'
require 'rspec'
require 'rake'
require 'rack/test'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)

    Dir.glob('./db/seeders/*.rb').each do |seeder|
      require seeder
    end
  end

  config.include RSpecMixin
end
