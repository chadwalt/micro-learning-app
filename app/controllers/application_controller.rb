require 'rubygems'
require 'sinatra/base'
require './config/environment'
require 'haml'
require 'base64'
require 'sinatra/partial'

# Base Controller for the application
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :session_secret, ENV.fetch('SESSION_SECRET')
    set :show_exceptions, :after_handler
    register Sinatra::Partial
    enable :partial_underscores
  end

  before do
    headers 'Content-Type' => 'text/html; charset=utf-8'
  end
end
