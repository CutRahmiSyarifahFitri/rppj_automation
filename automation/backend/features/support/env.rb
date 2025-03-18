require 'capybara/cucumber'
require 'data_magic'
require 'dotenv'
require 'json'
require 'jsonpath'
require 'json-schema'
require 'rspec/retry'
require 'rest-client'
require 'selenium-webdriver'
require 'site_prism'

require_relative '../../loader'
require_relative '../lib/response'
require_relative '../lib/faker_generator'

include FakerGenerator

p 'Loading env.rb'

# Load environment variables
load_environment

# set data magic default directory
DataMagic.yml_directory = './features/data'

SHORT_TIMEOUT = ENV['SHORT_TIMEOUT'].to_i
