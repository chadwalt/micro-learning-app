require_relative '../spec_helper'
require_relative '../../app/controllers/profile_controller'

describe ProfileController do
  before :each do
    @user_session = {user_id: 1}
    @user_data = {
      user: {
        first_name: 'timothy',
        last_name: 'kyadondo',
        username: 'chad',
        email: 'test@gmail.com',
        interests: ['Technology']
      }
    }
  end

  it 'should redirect to login when user has not signed in' do
    get '/'
    expect(last_response).to be_redirect
  end

  it 'should render the profile page' do
    get '/', {}, {'rack.session' => @user_session}

    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Profile')
  end

  it 'should update the user data' do
    post '/update_user', @user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:success]).to include('Successfully Saved')
  end

  it 'should update the user password with correct credentials' do
    @user_data = {
      user: {
        old_password: '123',
        password: '1223',
        password_confirmation: '1223'
      }
    }
    post '/change_password', @user_data, {'rack.session' => @user_session}
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:success]).to include('Password changed successfully')
  end

  it 'should not update the user password with password mismatches' do
    @user_data = {
      user: {
        old_password: '123',
        password: '1223',
        password_confirmation: '122323'
      }
    }
    post '/change_password', @user_data, {'rack.session' => @user_session}
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:error]).to include("Confirmation Password didn't match Password")
  end

  it 'should not update the user with wrong credentials' do
    @user_data = {
      user: {
        old_password: '1223',
        password: '1223',
        password_confirmation: '1223'
      }
    }
    post '/change_password', @user_data, {'rack.session' => @user_session}
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:error]).to include("Old password didn't match existing password")
  end
end