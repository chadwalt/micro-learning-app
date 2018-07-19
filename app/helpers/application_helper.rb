# Sinatra Helpers
module Sinatra
  # Application Helpers
  module AppHelpers
    def html_escaper(params)
      params.each do |key, value|
        params[key] = Rack::Utils.escape_html(value)
      end

      params
    end

    def user_roles
      %w[admin user]
    end
  end

  helpers AppHelpers
end
