require_relative '../spec_helper.rb'
require_relative '../../app/controllers/user_controller'

describe UserController do
  before :each do
    @user_session = {user_id: 1}
    @user_data = {
      user: {
        first_name: 'Wycliff',
        last_name: 'Kasirye',
        username: 'wyco',
        password: '123',
        email: 'wyco@gmail.com',
        role: 'user'
      }
    }
  end

  it 'should redirect to login when user has not signed in' do
    get '/'
    expect(last_response).to be_redirect
  end

  it 'should render the users page' do
    get '/', {}, {'rack.session' => @user_session}
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Users')
  end

  it 'should add users' do
    post '/add_user', @user_data, {'rack.session' => @user_session}
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:success]).to include('User saved successfully')
  end

  it 'should delete users' do
    get '/delete_user/1'
    expect(last_response).to be_redirect
  end
end