require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.default_formatter = 'doc'

  config.order = :random

  Kernel.srand config.seed

  # # rspec-mocks config goes here. You can use an alternate test double
  # # library (such as bogus or mocha) by changing the `mock_with` option here.
  # config.mock_with :rspec do |mocks|
  #   # Enable only the newer, non-monkey-patching expect syntax.
  #   # For more details, see:
  #   #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   mocks.syntax = :expect

  #   # Prevents you from mocking or stubbing a method that does not exist on
  #   # a real object. This is generally recommended.
  #   mocks.verify_partial_doubles = true
  # end
end
