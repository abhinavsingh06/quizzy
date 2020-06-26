require_relative 'boot'
require 'rails/all'
require "csv"

Bundler.require(*Rails.groups)

module Quizzy
  class Application < Rails::Application
    config.load_defaults 6.0

    config.active_job.queue_adapter = :sidekiq
  end
end
