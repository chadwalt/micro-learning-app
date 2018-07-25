# frozen_string_literal: true

require 'bundler/setup'
require 'mongo'
require 'mongoid'
require 'rack'
require 'dotenv/load'

Bundler.require(:default, ENV['RACK_ENV'])

configure :production, :development do
  enable :logging
  Mongoid.load!(File.expand_path(File.join('config', 'mongoid.yml')))
end
