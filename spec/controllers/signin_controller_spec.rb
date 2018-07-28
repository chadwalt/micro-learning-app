require_relative '../spec_helper'
require_relative '../../app/controllers/signin_controller'

describe SigninController do
  it 'should display the signin page' do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Yiigaa Signin')
  end

  it 'should login user with correct credentials and redirect to users with admin role' do
    user_data = {
      user: {
        email: 'timothy.kyadondo@gmail.com',
        password: '123'
      }
    }
    post '/signin', user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to include('user')
  end

  it 'should login user with correct credentials and redirect to page with user role' do
    user_data = {
      user: {
        email: 'james.kasule@gmail.com',
        password: '12345'
      }
    }

    post '/signin', user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to include('pages')
  end

  it 'should prevent login with wrong credentials' do
    user_data = {
      user: {
        email: 'james.kasule@gmail.com',
        password: 'kasule'
      }
    }

    post '/signin', user_data
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response.body).to include("Wrong Email/Password")
  end
end
