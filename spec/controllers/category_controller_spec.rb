require_relative '../spec_helper'
require_relative '../../app/controllers/category_controller'

describe CategoryController do
  before :each do
    @user_session = {user_id: 1}
    @category = {
      category: {
        name: 'Technology',
        description: 'Tech is here'
      }
    }
  end

  it 'should redirect to login if user_id not in session' do
    get '/'
    expect(last_response).to be_redirect
  end

  it 'should render the category page' do
    get '/', {}, {'rack.session' => @user_session}

    expect(last_response.status).to eq 200
    expect(last_response.body).to include('Category')
  end

  it 'should add a category' do
    post '/add_category', @category

    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:success]).to include('Category saved successfully')
  end

  it 'should edit a category' do
    @category = {
      category: {
        _id: 1,
        name: 'Sci',
        descrption: 'Science is awesome'
      }
    }
    post '/edit_category', @category

    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.session['flash'][:success]).to include('Category saved successfully')
  end

  it 'should delete a category' do
    post '/delete_category', {category_id: 1}

    expect(last_response.status).to eq(200)
    expect(last_request.session['flash'][:success]).to include('Category deleted successfully')
  end
end