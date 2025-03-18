# The `App` class serves as a container for page objects
# It provides memoized access to these objects to ensure each
# page object is only instantiated once per instance of the `App` class.
class App
  p 'call app.rb'
  def login_page
    @login_page ||= LoginPage.new
  end

  def dashboard_page
    @dashboard_page ||= DashboardPage.new
  end
end
