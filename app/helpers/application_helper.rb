# frozen_string_literal: true

# Sinatra Helpers
module Sinatra
  # Application Helpers
  module AppHelpers
    NEWSAPI = News.new(ENV['NEWS_API_KEY'])

    def html_escaper(params)
      params.each do |key, value|
        params[key] = Rack::Utils.escape_html(value)
      end

      params
    end

    def user_roles
      %w[admin user]
    end

    def get_news_feed(category)
      NEWSAPI.get_top_headlines(
        category: category,
        language: 'en',
        country: 'us'
      )
    end
  end

  helpers AppHelpers
end
