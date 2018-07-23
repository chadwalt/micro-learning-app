require_relative './application_controller'
require_relative '../models/user'

# Handles user profile.
class UserController < ApplicationController
  get '/' do
    redirect '/' unless session[:user_id]

    @title = 'Users'
    @css_link = 'style.css'
    @user = User.find_by(_id: session[:user_id])
    @users = User.all
    haml :users
  end

  post '/update_user' do
    if params[:user]['image']
      file = params[:user]['image']
      file_name = file[:filename]
      temp_file = file[:tempfile]

      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end

      params[:user]['image'] = file_name
      session[:image] = file_name
    end

    User.where(_id: session[:user_id]).update(params[:user])
    flash[:success] = 'Successfully Saved'

    redirect '/profile'
  end
end
