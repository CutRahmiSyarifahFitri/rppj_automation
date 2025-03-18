Given(/^user is on role login page$/) do
  p 'User trying open login page'
  visit ENV.fetch('BASE_URL_UI')
  waiting_for_page_ready
  @in_pencarian_page = page.current_url.include? 'reportvalidation'
  unless @in_pencarian_page
    p 'Waiting for username and password input fields'
    short_wait.until { @pages.login_page.has_input_username? }
    short_wait.until { @pages.login_page.has_input_password? }
  end
end

When(/^user role login as "(.*)"$/) do |user_account|
  p "User attempting to log in as #{user_account}"
  @user_account = user_account
  @login_data = @load_data.login_requirement.load_secret_details(user_account)
  @logged_in_user ||= @login_data['username']
  if @logged_in_user != @login_data['username'] && @in_pencarian_page
    p 'Need to logout from current session'
    step 'user click "Sign out" at header navigation bar in overview page'
    step 'user redirect to "Sign out" from overview page'
    waiting_for_page_ready
    @in_pencarian_page = page.current_url.include? 'flex'
    @logged_in_user = @login_data['username']
  end

  unless @in_pencarian_page
    p "Entering username and password for #{@login_data['username']}"
    @pages.login_page.input_username.set @login_data['username']
    @pages.login_page.input_password.set @login_data['password']
    p 'Clicking login button'
    @pages.login_page.btn_login.click
  end
end

When(/^user akses peran page$/) do
  p 'User navigating to roles page'
  waiting_for_page_ready
  @pages.roles_page.btn_peran.click
  waiting_for_page_ready
end

Then(/^logo element should be present$/) do
  p 'Verifying presence of logo element on roles page'
  waiting_for_page_ready
  expect(@pages.roles_page).to have_logo
end

When(/^user add new role$/) do
  p 'User clicking the Add New Role button'
  @pages.roles_page.btn_addnew.click
  waiting_for_page_ready
end

When(/^user inputs username "([^"]*)"$/) do |username|
  p "User is inputting username: #{username}"
  @pages.roles_page.input_namaperan.set(username)
end

When(/^user selects the dashboard checklist$/) do
  p 'User is selecting the dashboard checklist checkbox'
  find(:xpath, "(//span[@class='v-btn__content' and @data-no-activator='']//i[contains(@class, 'mdi-chevron-down') and contains(@class, 'v-icon')])[1]").click
end

When(/^user clicks the switch button$/) do
  p 'User is clicking the switch button'

  # Menggunakan JavaScript untuk mengklik jika elemen terhalang
  page.execute_script('arguments[0].click();', @pages.roles_page.btn_switch.native)

  waiting_for_page_ready
end

When(/^user clicks the simpan button$/) do
  p 'User is clicking the simpan button'
  @pages.roles_page.btn_simpan.click
  waiting_for_page_ready
end

When(/^user inputs filter namaperan "(.*?)"$/) do |namaperan|
  p "User is inputting filter namaperan: #{namaperan}"
  @pages.roles_page.filter_namaperan.set(namaperan)
end

When(/^user clicks filter status$/) do
  p 'User is clicking the filter status input'
  @pages.roles_page.wait_until_filter_status_visible # Tunggu hingga filter status terlihat
  page.execute_script('arguments[0].click();', @pages.roles_page.filter_status.native) # Klik dengan JavaScript
  waiting_for_page_ready # Pastikan halaman sudah siap setelah klik
end

When(/^user clicks the dropdown icon$/) do
  @pages.roles_page.status_dropdown.click
end

When(/^user clicks the edit button$/) do
  p 'user is clicking the edit button'
  expect(page).to have_selector(:xpath, "(//button[contains(@class, 'v-btn') and contains(@class, 'v-btn--elevated') and contains(@class, 'v-btn--icon') and contains(@class, 'v-theme--light')])[3]",
visible: true, wait: 5)
  @pages.roles_page.btn_edit.click
  waiting_for_page_ready
end

When(/^user inputs rolename "([^"]*)"$/) do |role_name|
  p "User is input role name: #{role_name}"
  @pages.roles_page.role_name_input.set(role_name)
end

When(/^user click the pencarian button$/) do
  p 'User is selecting the searching checklist checkbox'
  find(:xpath, "(//span[@class='v-btn__content' and @data-no-activator='']//i[contains(@class, 'mdi-chevron-down') and contains(@class, 'v-icon')])[2]").click
  waiting_for_page_ready
end

When(/^user clicks the save button$/) do
  p 'User is clicking the save button'
  @pages.roles_page.btn_edit_save.click
  waiting_for_page_ready
end

When(/^user click notif the save button$/) do
  p 'user is clicking notif the save button'
  @pages.roles_page.btn_notif_save.click
  waiting_for_page_ready
end

Then(/^user should see the success message$/) do
  expect(@pages.roles_page).to have_notif_success(wait: 5)
end
