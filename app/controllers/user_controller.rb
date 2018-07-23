require_relative './application_controller'
require_relative '../models/user'

# Handles user profile.
class UserController < ApplicationController
  error Mongo::Error::OperationFailure do |error|
    if error.message.include? 'E11000'
      flash[:error] = 'Email taken, please use another'
      redirect to('/')
    end
  end

  error Mongoid::Errors::DocumentNotFound do
    flash[:error] = 'Wrong Email/Password'
    redirect to('/')
  end
  
  get '/' do
    redirect '/' unless session[:user_id]

    @title = 'Users'
    @css_link = 'style.css'
    @user = User.find_by(_id: session[:user_id])
    @users = User.all
    haml :users
  end

  post '/add_user' do
    @user = User.new(html_escaper(params[:user]))

    if @user.save
      flash[:success] = 'User saved successfully'
    else
      flash[:error] = @user.errors.full_messages
    end

    redirect '/user'
  end

  get '/delete_user/:user_id' do
    user_id = escape_html(params.fetch('user_id'))
    user = User.find_by(_id: user_id)
    user.delete
    redirect to('/')
  end
end
