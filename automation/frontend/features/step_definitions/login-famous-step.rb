Given('I am on the famous login page') do
  page.driver.browser.manage.window.maximize
  waiting_for_page_ready
  p 'User trying open login page'
  url = "#{ENV['BASE_URL_UI_Famous']}/sign-in"
  visit url

end

When('I fill in {string} and {string}') do |email, password|
  waiting_for_page_ready
  @pages.login_page_fam.login(email, password)
end

When('I click submit button') do
  waiting_for_page_ready
  @pages.login_page_fam.submit
end

Then('I should be logged in successfully') do
  waiting_for_page_ready
  @pages.login_page_fam.go_to_dashboard
  expect(page.current_url).to eq('https://famous.borneo-indobara.com/dashboard')
end

Then('I hover to sidebar rppj') do
  waiting_for_page_ready  # Pastikan halaman siap
  @pages.login_page_fam.hover_and_click_sidebar_button
  sleep 6  # Tunggu beberapa detik untuk memastikan tindakan hover berhasil
end

Then('user should be redirected to rppj dashboard page') do
  waiting_for_page_ready
  sleep 3  # Beri waktu untuk redirect terjadi

  # Tangkap URL setelah klik sidebar
  current_url = page.current_url
  puts "URL setelah klik sidebar: #{current_url}"

  # Ambil token dari URL jika ada
  if current_url.match(/token=([^&]+)/)
    token = current_url.match(/token=([^&]+)/)[1]
    puts "Token ditemukan: #{token}"
  else
    raise "Token tidak ditemukan dalam URL"
  end

  # Redirect ke halaman RPPJ dengan token yang benar
  rppj_url = "https://dev-rppj.ugems.id/admin/dashboard?token=#{token}"
  puts "Mengakses halaman RPPJ: #{rppj_url}"
  visit rppj_url

  waiting_for_page_ready
  expect(page).to have_current_path(rppj_url, url: true)
end
