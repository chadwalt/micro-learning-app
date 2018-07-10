require_relative '../models/user_model'

class SignupController < ApplicationController

  get "/" do
    @css_link = "index.css"
    @error_message = session[:error]
    haml :signup
  end

  post "/user_info" do
    first_name = params.fetch('first_name')
    last_name = params.fetch('last_name')
    username = params.fetch('username')
    password = params.fetch('password')
    confirm_password = params.fetch('confirm_password')
    email = params.fetch('email')

    if password != confirm_password then
      session[:error] = "Password's didn't match"
      redirect to("/")
    end

    session.delete(:error) if session[:error]

    User.create(
      first_name: first_name,
      last_name: last_name,
      username: username,
      password: Base64.encode64(password),
      email: email
    )

  end
end