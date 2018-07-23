require_relative './application_controller'
require_relative '../models/user'

# Signin the user into the application.
class SigninController < ApplicationController
  error Mongoid::Errors::DocumentNotFound do
    flash[:error] = 'Wrong Email/Password'
    redirect to('/')
  end

  get '/' do
    @css_link = 'index.css'
    haml :signin
  end

  post '/signin' do
    submited_data = html_escaper(params[:user])
    user = User.find_by(email: submited_data[:email]).try(
      :authenticate,
      submited_data[:password]
    )

    session[:user_id] = user[:_id]
    session[:image] = user[:image]

    redirect to('/dashboard')
  end
end
