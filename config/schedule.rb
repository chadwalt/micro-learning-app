set :environment, ENV['RACK_ENV']

every :day, at: '12:00am' do
  rake 'send_emails:mail'
end
