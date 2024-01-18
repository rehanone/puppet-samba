source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :development do
end

# The test group is used for static validations and unit tests in gha-puppet's
# basic and beaker gha-puppet workflows.
group :test do
  # Require the latest Puppet by default unless a specific version was requested
  # CI will typically set it to '~> 7.0' to get 7.x
  gem 'puppet', ENV.fetch('PUPPET_GEM_VERSION', '>= 0'), require: false

  # Needed to build the test matrix based on metadata
  gem 'puppet_metadata', '~> 3.4', require: false

  # Needed for the rake tasks
  gem 'puppetlabs_spec_helper', '>= 2.16.0', '< 7', require: false

  # Rubocop versions are also specific so it's recommended
  # to be precise. Can be turned off via a parameter
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false

  # metagem that pulls in all further requirements
  gem 'voxpupuli-test', '~> 7.0', require: false
end
