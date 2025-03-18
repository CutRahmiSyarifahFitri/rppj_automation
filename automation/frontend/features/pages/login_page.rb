# `LoginPage`` class serves as a container for login page objects
class LoginPage < SitePrism::Page
  set_url '/sign-in'

  # Login form
  element :input_username, '#username'
  element :input_password, '#password'

  element :btn_login, '#login-button'
  element :btn_login_google, '#login-with-google'

  element :icon_eye, :xpath,
          "//input[@id='password']/following-sibling::span[contains(@class, 'ant-input-suffix')]//span"

  element :alert_description,
          '.ant-alert-message'

  element :notification_login_description,
          '.ant-notification-notice-description'
end
