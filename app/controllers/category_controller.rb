require_relative './application_controller'
require_relative '../models/category'

# Category controller handles all CRUD operations of the category.
class CategoryController < ApplicationController
  error Mongoid::Errors::DocumentNotFound do
    session[:error] = 'Wrong Email/Password'
    redirect to('/')
  end

  get '/' do
    redirect '/' unless session[:user_id]

    @title = 'Category'
    @css_link = 'style.css'
    @user = User.find_by(_id: session[:user_id])
    @categories = Category.all
    haml :category
  end

  post '/add_category' do
    submitted_data = html_escaper(params[:category])
    submitted_data.delete(:_id)
    @category = Category.new(submitted_data)

    if @category.save
      session[:success] = 'Category saved successfully'
    else
      session[:error] = 'Category not saved successfully'
    end

    redirect to('/')
  end

  post '/edit_category' do
    submitted_data = html_escaper(params[:category])
    Category.where(_id: submitted_data[:_id]).update(submitted_data)

    session[:success] = 'Category saved successfully'

    redirect to('/')
  end

  post '/delete_category' do
    category_id = escape_html(params.fetch('category_id'))
    Category.where(_id: category_id).delete

    session[:success] = 'Category saved successfully'
    { success: true, message: 'category_deleted' }.to_json
  end
end
