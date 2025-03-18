require_relative 'global_section'
class LoginPageFam < SitePrism::Page
  set_url '/sign-in'

  element :email_field, 'input#input-email'
  element :password_field, 'input#input-password'
  element :submit_button, 'button#button-login'
  element :dashboard, :xpath, "//div[contains(text(),'Intelligent Remote Dispatch Control')]"
  element :rppj_sidebar, :xpath, "//a[contains(@href, '/rppj')]"
  element :sidebar_button, :css, 'a.MuiListItem-button[href="/rppj"]' 
  element :rppj_dashboard, :url, 'https://rppj.famous.co.id/dashboard'

  def login(email, password)
    email_field.set(email)
    password_field.set(password)
  end

  def submit
    submit_button.click
  end

  def go_to_dashboard
    visit 'https://famous.borneo-indobara.com/dashboard'
  end

  def go_to_rppj
    visit 'https://famous.borneo-indobara.com/rppj' 
  end

  def hover_and_click_sidebar_button
    sidebar_button.hover
    sleep 1  # Tunggu sebentar setelah hover
    sidebar_button.click
    sleep 2  # Tunggu menu terbuka atau halaman berpindah
  end

end