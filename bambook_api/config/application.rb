require_relative 'boot'
require 'rails/all'
require 'rails'
require 'pry' if Rails.env.development?
Bundler.require(*Rails.groups)

module BambookApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    config.autoload_paths += Dir["#{config.root}/app/api/**/**/"]
    config.autoload_paths += Dir["#{config.root}/app/**/**/"]

    # autoloads lib folder during production
    config.eager_load_paths << Rails.root.join('lib')

    # autoloads lib folder during development
    config.autoload_paths << Rails.root.join('lib')
  end
end
