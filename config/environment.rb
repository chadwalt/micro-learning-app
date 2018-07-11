require 'bundler/setup'
require 'mongo'
require 'mongoid'
require 'rack'

ENV['RACK_ENV'] ||= "development"
ENV['SESSION_SECRET'] = "c76293fd-7df5-452d-8f24-49832ea148d7"

Bundler.require(:default, ENV.fetch('RACK_ENV'))

configure :production, :development do
  enable :logging
  Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")))
end
