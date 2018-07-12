require 'mongoid'
require 'logger'
logger = Logger.new($stdout)

ROOT = File.expand_path('.', File.dirname(__FILE__))

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
