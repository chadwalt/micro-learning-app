# frozen_string_literal: true

require 'rubygems'
require 'sinatra/base'
require './config/environment'
require 'haml'
require 'base64'
require 'sinatra/partial'
require 'sinatra/flash'
require 'news-api'
require_relative '../helpers/application_helper'

# Base Controller for the application
class ApplicationController < Sinatra::Base
  helpers Sinatra::AppHelpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
    set :session_secret, ENV['SESSION_SECRET']
    set :show_exceptions, :after_handler
    register Sinatra::Partial
    enable :partial_underscores
    register Sinatra::Flash
  end

  before do
    headers 'Content-Type' => 'text/html; charset=utf-8'
  end
end
