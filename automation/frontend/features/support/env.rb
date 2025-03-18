require 'capybara/cucumber'
require 'data_magic'
require 'dotenv'
require 'rspec/retry'
require 'selenium-webdriver'
require 'site_prism'
require_relative '../support/response_saver'
require_relative '../../loader'
require_relative '../lib/base_helper'
require_relative '../lib/cucumber_ui_helper'
require_relative '../lib/faker_generator'
require_relative 'response_saver'

include BaseHelper
include CucumberUIHelper
include FakerGenerator

p 'Loading env.rb'

# Load environment variables
load_environment

# set data magic default directory
DataMagic.yml_directory = './features/data'

SHORT_TIMEOUT = ENV['SHORT_TIMEOUT'].to_i

# Determine if we should run in headless mode
headless = ENV.fetch('HEADLESS', 'true') == 'true'

# Configure Chrome options to allow microphone permissions and disable popups
chrome_options = Selenium::WebDriver::Chrome::Options.new
chrome_options.add_preference('profile.default_content_setting_values.media_stream_mic', 1)
chrome_options.add_preference('profile.default_content_setting_values.media_stream_camera', 1) # Camera permission
chrome_options.add_argument('--use-fake-ui-for-media-stream')
chrome_options.add_argument('--use-fake-device-for-media-stream')
chrome_options.add_argument('--disable-infobars') # Disable "Chrome is being controlled by automated test software" infobar
chrome_options.add_argument('--disable-notifications') # Disable notifications
chrome_options.add_argument('--disable-extensions') # Disable extensions
chrome_options.add_argument('--disable-popup-blocking') # Disable popup blocking
chrome_options.add_argument('--disable-features=TranslateUI') # Disable Chrome's translation bar
chrome_options.add_argument('--no-first-run') # Skip first run wizards
chrome_options.add_argument('--no-default-browser-check') # Skip default browser check
chrome_options.add_argument('--disable-translate') # Disable automatic translation prompts
chrome_options.add_argument('--disable-gpu') # Disable GPU hardware acceleration

# Add headless option dynamically
if headless
  chrome_options.add_argument('--headless')
  # chrome_options.add_argument('--disable-gpu')
  chrome_options.add_argument('--no-sandbox')
  chrome_options.add_argument('--disable-dev-shm-usage')
  chrome_options.add_argument('window-size=1400,1400')
end

# Register the Chrome driver with microphone permissions
Capybara.register_driver :selenium_chrome_with_mic_permissions do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

# Set Capybara configurations
Capybara.app_host = ENV.fetch('BASE_URL_UI')
Capybara.default_driver = :selenium_chrome_with_mic_permissions
