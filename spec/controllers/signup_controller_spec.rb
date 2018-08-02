# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../app/controllers/signup_controller'

describe SignupController do
  before :each do
    @user_data = {
      user: {
        first_name: 'timothy',
        last_name: 'kyadondo',
        username: 'chad',
        password: '123',
        password_confirmation: '123',
        email: 'test@gmail.com'
      }
    }
  end

  it 'should display the signup page' do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Account Signup')
  end

  it 'should redirect to /profile on successuful account creation' do
    post '/user_info', @user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to include('profile')
  end

  it 'should redirect to /signup on password mismatch' do
    @user_data[:user][:password_confirmation] = '12345'

    post '/user_info', @user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response.body).to include("Password confirmation doesn't match Password")
  end

  it 'should redirect to /signup when email is already taken' do
    @user_data[:user][:email] = 'timothy.kyadondo@gmail.com'

    post '/user_info', @user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response.body).to include('Email taken, please use another')
  end
end
