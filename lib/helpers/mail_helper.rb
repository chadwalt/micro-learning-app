require 'mail'
require 'dotenv/load'

# Mail Helpers
module MailHelpers
  # Sends mails to receipts using gmail as the stmp.
  # email_to => Email that will be recieving the mail
  # subject => The subject of the email
  # body => The contents of the email
  def self.send_mail(email_to, subject, body)
    options = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: ENV['EMAIL_DOMAIN'],
      user_name: ENV['EMAIL_USERNAME'],
      password: ENV['EMAIL_PASSWORD'],
      authentication: 'plain',
      enable_starttls_auto: true
    }

    Mail.defaults do
      delivery_method :smtp, options
    end

    mail = Mail.new do
      from      ENV['EMAIL']
      to        email_to
      subject   subject

      html_part do
        content_type 'text/html; charset=UTF-8'
        body body
      end
    end

    mail.deliver
  end
end
