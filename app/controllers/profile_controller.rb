require_relative './application_controller'
require_relative '../models/user'

# Handles user profile.
class ProfileController < ApplicationController
  get '/' do
    redirect '/' unless session[:email]

    @css_link = 'style.css'
    @user = User.find_by(email: session[:email])
    session[:user]['image'] = @user.image
    haml :profile
  end

  post '/update_user' do
    if file = params[:user]['image']
      file_name = file[:filename]
      temp_file = file[:tempfile]

      File.open("./public/images/#{file_name}", 'wb') do |f|
        f.write(temp_file.read)
      end

      params[:user]['image'] = file_name
    end

    User.where(email: session[:email]).update(params[:user])
    session[:user] = params[:user]
    session[:success] = "Successfully Saved"

    redirect '/profile'
  end

  post '/change_password' do
    user = User.find_by(email: session[:email])

    if user.authenticate(params[:user]['old_password'])
      if params[:user]['password'] == params[:user]['password_confirmation']
        user.update_attributes(password_digest: params[:user]['old_password'])
        session[:success] = "Password changed successfully"
        session.delete(:error) if session[:error]
      else
        session[:error] = "Confirmation Password didn't match Password"
      end
    else
      session[:error] = "Old password didn't match existing password"
    end

    redirect '/profile'
  end
end
