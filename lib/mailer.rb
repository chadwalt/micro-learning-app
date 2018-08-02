# frozen_string_literal: true

require 'news-api'
require './config/environment'
require_relative '../app/models/user'
require_relative '../app/models/category'
require_relative './helpers/mail_helper'

## Send mails to users with interests.
class Mailer
  @users = User.all.to_a
  @categories = Category.all.to_a
  @pages = {}
  @email_subject = 'Things to learn'
  @newsapi = News.new(ENV['NEWS_API_KEY'])

  def self.news_feeds(category)
    @newsapi.get_top_headlines(
      category: category,
      language: 'en',
      country: 'us'
    )
  end

  def self.pages
    @categories.each do |value|
      @pages[value[:name]] = news_feeds(value[:name])
    end
  end

  def self.send_emails
    @users.each do |value|
      next unless value[:interests]
      body = '<p>Here are things to learn about </p>' \
        "<p>Title: #{@pages[value[:interests][0]][0].title}</p>" \
        "<p>Description: #{@pages[value[:interests][0]][0].description}</p>"

      MailHelpers.send_mail(value[:email], @email_subject, body)
    end
  end

  private_class_method :news_feeds
end
