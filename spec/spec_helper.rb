# frozen_string_literal: true

require_relative '../app/controllers/application_controller'
require 'rspec'
require 'rake'
require 'rack/test'
require 'database_cleaner'
require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start do
  ignore = %w[spec seeders]

  ignore.each do |files|
    add_filter files
  end
end

ENV['RACK_ENV'] = 'test'
enable :sessions

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

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.include RSpecMixin
end
