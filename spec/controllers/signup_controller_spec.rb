require_relative '../spec_helper'
require_relative '../../app/controllers/signup_controller'
require_relative '../../app/models/user_model'

describe SignupController do
  it 'should display the signup page' do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Account Signup')
  end
end
