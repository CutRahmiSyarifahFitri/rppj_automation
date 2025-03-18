Given(/^user is on login page$/) do
  p 'User trying open login page'
  url = "#{ENV.fetch('BASE_URL_UI')}auth/login"
  visit url
  waiting_for_page_ready
  @in_pencarian_page = page.current_url.include? 'reportvalidation'
  unless @in_pencarian_page
    short_wait.until { @pages.login_page.has_input_username? }
    short_wait.until { @pages.login_page.has_input_password? }
  end
end

When(/^user login as "(.*)"$/) do |user_type_details|
  @user_type_details = user_type_details
  @data_login = @load_data.login_requirement.load_secret_details(user_type_details)
  @current_user ||= @data_login['username']
  if @current_user != @data_login['username'] && @in_pencarian_page
    p 'need to logout'
    step 'user click "Sign out" at header navigation bar in overview page'
    step 'user redirect to "Sign out" from overview page'
    waiting_for_page_ready
    @in_pencarian_page = page.current_url.include? 'flex'
    @current_user = @data_login['username']
  end

  unless @in_pencarian_page
    @pages.login_page.input_username.set @data_login['username']
    @pages.login_page.input_password.set @data_login['password']
    @pages.login_page.btn_login.click
  end
end

Then(/^user should be redirected to dashboard page$/) do
  waiting_for_page_ready
  @pages.dashboard_page.wait_until_navbar_visible

  expect(@pages.dashboard_page).to have_dashboard_title
end

Then(/^user should see error "(.*)"$/) do |error_msg|
  waiting_for_page_ready
  expect(@pages.login_page).to have_alert_description
  expect(@pages.login_page.alert_description.text.split("\n").first).to eq error_msg
end

When(/^user enter password "(.*)"$/) do |password|
  @pages.login_page.input_password.set(password)
end

When(/^user clicks on the "(.*)" eye icon$/) do |scenario|
  case scenario
  when 'show_password'
    @pages.login_page.icon_eye.click
  when 'hide_password'
    @pages.login_page.icon_eye.click
    @pages.login_page.icon_eye.click
  end
end

Then(/^the password field should be "(.*)"$/) do |visibility|
  case visibility
  when 'visible'
    expect(@pages.login_page.input_password[:type]).to eq('text')
  when 'hidden'
    expect(@pages.login_page.input_password[:type]).to eq('password')
  end
end
