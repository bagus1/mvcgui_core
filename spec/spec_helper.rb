
# Please do not alter these: they are intending to allow for both simplecov and cc integration
# When intergrated into the same step, simplecov will not regenerate the coverage index.html
require 'pry'
if ENV['COV']
  require 'simplecov'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter
  ]
  SimpleCov.start 'rails' do
    add_filter '/.bundle/'
    add_group 'Ignored Code' do |src_file|
      open(src_file.filename).grep(/:nocov:/).any?
    end
  end
  puts "Running Simplecov...\n"
end

if ENV['CC']
  ENV['CODECLIMATE_REPO_TOKEN'] = '2b1fb19914c047843778969c7e144e3a2d2047d6f9d9646c339265a79e384028'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
  puts "Running CodeClimate...\n"
end

require 'action_mailer'
require 'rubygems'
require 'spork'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  # require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'email_spec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    config.before(:each) { GC.disable }
    config.after(:each) { GC.enable }

    config.include EmailSpec::Helpers
    config.include EmailSpec::Matchers
    config.include FactoryGirl::Syntax::Methods
    config.use_transactional_fixtures = true
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = 'random'
    config.include JsonSpec::Helpers

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end
    config.before(:each) do
      DatabaseCleaner.start
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.before(:each) do
      stub_request(:any, /api.mallfinder.com/).to_rack(FakeMdb)
      stub_request(:any, /bass.shoptopia.com/).to_rack(FakeBass)

    end
  end
end

Spork.each_run do

end
