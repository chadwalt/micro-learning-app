# frozen_string_literal: true

require_relative './application_controller'
require_relative '../models/user'
require_relative '../models/category'

# Handles user profile.
class ProfileController < ApplicationController
  get '/' do
    redirect '/' unless session[:user_id]

    @css_link = 'style.css'
    @user = User.find_by(_id: session[:user_id])
    @categories = Category.all
    haml :profile
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

  post '/change_password' do
    user = User.find_by(_id: session[:user_id])

    submitted_data = html_escaper(params[:user])

    if user.authenticate(submitted_data[:old_password])
      if submitted_data[:password] == submitted_data[:password_confirmation]
        user.update_attributes(password_digest: submitted_data[:password])
        flash[:success] = 'Password changed successfully'
      else
        flash[:error] = "Confirmation Password didn't match Password"
      end
    else
      flash[:error] = "Old password didn't match existing password"
    end

    redirect '/profile'
  end
end
