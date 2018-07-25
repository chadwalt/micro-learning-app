require 'news-api'
require './config/environment'
require_relative '../app/models/user'
require_relative '../app/models/category'
require_relative './helpers/mail_helper'

users = User.all
categories = Category.all
pages = {}
email_body = 'Here is a new page to learn about '
@newsapi = News.new(ENV['NEWS_API_KEY'])

def get_news_feed(category)
  @newsapi.get_top_headlines(
    category: category,
    language: 'en',
    country: 'us'
  )
end

categories.each do |value|
  pages[value.name] = get_news_feed(value.name)
end

users.each do |value|
  if value.interests
    body = "<p>Here are things to learn about </p>" \
      "<p>Title: #{pages[value.interests[0]][0].title}</p>" \
      "<p>Description: #{pages[value.interests[0]][0].description}</p>"

    MailHelpers.send_mail(value.email, 'Things to learn', body)
  end
end
