require_relative '../app/controllers/application_controller'
require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure { |config| config.include RSpecMixin }
