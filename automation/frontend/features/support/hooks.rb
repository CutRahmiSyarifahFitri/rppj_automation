require 'fileutils'

screenshots_path = 'features/report/failed/screenshots'

p 'call hooks.rb'

# Define a method to clear the screenshots folder
def clear_screenshots_folder(screenshots_path)
  if Dir.exist?(screenshots_path)
    FileUtils.rm_rf(Dir.glob("#{screenshots_path}/*"))
    p 'Cleared screenshots folder before starting tests'
  else
    FileUtils.mkdir_p(screenshots_path)
    p 'Created screenshots folder before starting tests'
  end
end

# Clear the screenshots folder before the test suite starts
clear_screenshots_folder(screenshots_path) if ENV['PARALLEL_TEST']

Before do |scenario|
  @pages = App.new
  @load_data = LoadData.new
  p "Scenario to run: #{scenario.name}"
  p "Running in parallel: #{!ENV['TEST_ENV_NUMBER'].nil?}"
end

After do |scenario|
  # Check if the scenario failed
  if scenario.failed?
    # Save the screenshot
    timestamp = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    status = scenario.failed? ? 'FAILED' : 'PASSED'
    screenshot_name = "#{screenshots_path}/#{scenario.name.gsub(' ', '_')}_#{status}_#{timestamp}.png"
    save_screenshot(screenshot_name) if defined?(save_screenshot) # rubocop:disable Lint/Debugger

    p "Screenshots saved to #{screenshot_name}"
    attach(screenshot_name, 'image/png') if defined?(attach)
  end

  # Ensure the driver is quit to close the browser
  # Capybara.current_session.driver.quit

  # Log that the scenario is completed
  p 'Scenario finished'
end
