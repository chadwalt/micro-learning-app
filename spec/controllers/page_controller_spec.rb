require_relative '../spec_helper'
require_relative '../../app/controllers/page_controller'

describe PageController do
  before :each do
    @user_session = {user_id: 1}
  end

  it 'should redirect to login when user has not signed in' do
    get '/'
    expect(last_response).to be_redirect
  end

  it 'should render the pages page' do
    get '/', {}, {'rack.session' => @user_session}
    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Pages')
  end
end