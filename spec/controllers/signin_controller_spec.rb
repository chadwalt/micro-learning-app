require_relative '../spec_helper'
require_relative '../../app/controllers/signin_controller'
require_relative '../../app/models/user'

describe SigninController do
  it 'should display the signin page' do
    get '/'
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Yiigaa Signin')
  end
end
