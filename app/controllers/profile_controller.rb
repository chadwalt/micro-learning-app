require_relative './application_controller'
require_relative '../models/user'

# Handles user profile.
class ProfileController < ApplicationController
  get '/' do
    @css_link = 'style.css'
    @error_message = session[:error]
    haml :profile
  end
end