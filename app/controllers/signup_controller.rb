require_relative './application_controller'
require_relative '../models/user'

# Create account for a new user
class SignupController < ApplicationController
  error Mongo::Error::OperationFailure do |error|
    if error.message.include? 'E11000'
      session[:error] = 'Email taken, please use another'
      redirect to('/')
    end
  end

  get '/' do
    @css_link = 'index.css'
    @error_message = session[:error]
    haml :signup
  end

  post '/user_info' do
    @user = User.new(params[:user])

    if @user.save
      session.delete(:error) if session[:error]
      session[:email] = @user.email
      redirect '/profile'
    else
      session[:error] = @user.errors.full_messages
      redirect to('/')
    end
  end
end
