require 'sinatra/base'
require './config/environment'
require 'haml'
require 'base64'

class ApplicationController < Sinatra::Base

  @title = "Yiiga"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :session_secret, ENV.fetch('SESSION_SECRET')
  end

  before do
    headers "Content-Type" => "text/html; charset=utf-8"
  end

end