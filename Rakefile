require 'mongoid'
require 'logger'

logger = Logger.new($stdout)
ROOT = File.expand_path('.', File.dirname(__FILE__))

## Usage - rake 'mongoid:create_indexes[RACK_ENV]'
namespace :mongoid do
  task :create_indexes, :environment do |_t, args|
    def determine_model(path)
      path =~ /^(.*)\/(.*).rb/
      $2.camelize.constantize
    end

    unless args[:environment]
      logger.fatal 'Mongoid: Must provide an environment'
      exit
    end

    yaml = YAML.load_file('config/mongoid.yml')
    env_info = yaml[args[:environment]]

    unless env_info
      logger.fatal 'Mongoid: Unknown environment'
      exit
    end

    Mongoid.configure do |config|
      config.load_configuration(env_info)
    end

    Dir.glob('./app/{models}/*.rb').each do |model|
      require model
      klass = determine_model(model)

      if klass.ancestors.include?(Mongoid::Document)
        klass.create_indexes
        logger.info "Mongoid: Indexes Processed for \"#{klass}\""
      end
    end
  end
end

## Usage - rake 'db:seed[RACK_ENV]'
namespace :db do
  task :seed, :environment do |_t, args|
    yaml = YAML.load_file('config/mongoid.yml')
    env_info = yaml[args[:environment]]

    unless env_info
      logger.fatal 'Mongoid: Unknown environment'
      exit
    end

    Mongoid.configure do |config|
      config.load_configuration(env_info)
    end

    Dir.glob('./db/seeders/*.rb').each do |seeder|
      require seeder
      logger.info "Seeder created for #{seeder}"
    end
  end
end

## Send emails to all users who have interests
## Usage - rake send_emails:mail
namespace :send_emails do
  task :mail do
    require_relative './lib/mailer'

    Mailer.pages
    Mailer.send_emails

    logger.info 'Emails sent'
  end
end
