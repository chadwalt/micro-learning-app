require_relative './application_controller'
require_relative '../models/user'

# Create account for a new user
class SignupController < ApplicationController
  error Mongo::Error::OperationFailure do |error|
    if error.message.include? 'E11000'
      flash[:error] = 'Email taken, please use another'
      redirect to('/')
    end
  end

  get '/' do
    @css_link = 'index.css'
    @error_message = flash[:error]
    haml :signup
  end

  post '/user_info' do
    @user = User.new(params[:user])

    if @user.save
      user_info = User.find_by(email: params[:user][:email])
      session[:user_id] = user_info[:_id]
      session[:image] = user_info[:image]
      redirect '/profile'
    else
      flash[:error] = @user.errors.full_messages
      redirect to('/')
    end
  end
end
