require_relative './application_controller'

# Handle the display of pages.
class PageController < ApplicationController
  get '/' do
    redirect '/' unless session[:user_id]

    @title = 'Pages'
    @css_link = 'style.css'
    @user = User.find_by(_id: session[:user_id])
    @pages = []

    if @user.interests
      @user.interests.each do |value|
        @pages.push(*get_news_feed(value))
      end
    end

    haml :pages
  end
end
