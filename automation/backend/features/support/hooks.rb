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
  RestClient.log = 'stdout' if ENV['CUCUMBER_API_VERBOSE'] == 'true'
  $cache = {}
  p "Scenario to run: #{scenario.name}"
  p "Running in parallel: #{!ENV['TEST_ENV_NUMBER'].nil?}"
end

After do |scenario|
  if scenario.failed?
    # Assuming you have access to the request and response objects
    p "Scenario failed: #{scenario.name}"

    # Example logging of request and response data
    # if defined?(@response)
    #   p "====: Request URL: #{@response.request.url}"
    #   p "====: Request Headers: #{@response.request.headers}"
    #   p "====: response: #{@response}"
    # end

    # Attach the response body to the Cucumber report (if needed)
    attach(@response.body, 'application/json') if @response.body
  end
end
