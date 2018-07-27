require_relative './application_controller'
require_relative '../models/user'

# Signin the user into the application.
class SigninController < ApplicationController
  error Mongoid::Errors::DocumentNotFound do
    flash[:error] = "Email doesn't exist"
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

    if user
      session[:user_id] = user[:_id]
      session[:image] = user[:image]

      redirect '/user' if user[:role] == user_roles[0]
      redirect '/pages'
    else
      flash[:error] = 'Wrong Email/Password'
      redirect to('/')
    end
  end

  get '/logout' do
    session.clear
    redirect to('/')
  end
end
