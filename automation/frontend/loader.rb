# loader.rb

p 'call loader.rb'

# Determine the project root directory
PROJECT_ROOT = File.expand_path('../../', __dir__)

# Add specific directories to the load path
lib_path = File.join(PROJECT_ROOT, 'lib')
config_path = File.join(PROJECT_ROOT, 'config')

$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)
$LOAD_PATH.unshift(config_path) unless $LOAD_PATH.include?(config_path)

# Require the necessary files
require 'env_loader'
require 'helper'
require 'rake_helpers/gcs_helper'
require 'rake_helpers/email_helper'
require 'initializers/report_builder'

relative_cred_path = ENV['GOOGLE_APPLICATION_CREDENTIALS']
ENV['GOOGLE_APPLICATION_CREDENTIALS'] = File.expand_path(relative_cred_path, PROJECT_ROOT)
