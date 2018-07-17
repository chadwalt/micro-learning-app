require_relative './application_controller'
require_relative '../models/user'

# Signin the user into the application.
class SigninController < ApplicationController
  error Mongoid::Errors::DocumentNotFound do
    session[:error] = 'Wrong Email/Password'
    redirect to('/')
  end

  get '/' do
    @css_link = 'index.css'
    @error_message = session[:error]
    haml :signin
  end

  post '/signin' do
    user = User.find_by(email: params[:user]['email']).try(
      :authenticate,
      params[:user]['password']
    )

    session[:username] = params[:user]['username']
    session[:email] = params[:user]['email']
    session.delete(:error) if session[:error]

    redirect to('/dashboard')
  end
end
