require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AnkranNembo
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths << "#{Rails.root}/lib"
  end
end
