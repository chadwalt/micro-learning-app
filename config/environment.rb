require 'bundler/setup'
require 'mongo'
require 'mongoid'

ENV['SINATRA_ENV'] ||= "development"
ENV['SESSION_SECRET'] = "c76293fd-7df5-452d-8f24-49832ea148d7"

Bundler.require(:default, ENV.fetch('SINATRA_ENV'))

configure :production, :development do
  enable :logging
  Mongoid.load!(File.expand_path(File.join("config", "mongoid.yml")))
end
