# encoding: UTF-8

# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  def mock_runner(opts = {})
    mock_model(Runner, valid_runner_attributes.merge(opts))
  end

  def valid_runner_attributes
    {:name => "Pekka Itävuo",
     :first_name => "Pekka",
     :last_name => "Itävuo"}
  end

  def mock_run(opts = {})
    mock_model(Run, valid_run_attributes.merge(opts))
  end

  def valid_run_attributes
    {}
  end

  def mock_event(opts = {})
    mock_model(Event, valid_event_attributes.merge(opts))
  end

  def valid_event_attributes
    {:event_date => Date.new(2007,11,23)}
  end
end
