require 'mail'

# Configure Mail gem for Gmail SMTP
Mail.defaults do
  delivery_method :smtp, {
    address: ENV['SMTP_ADDRESS'],
    port: ENV['PORT'],
    domain: ENV['DOMAIN'],
    user_name: ENV['EMAIL_ADMIN'],
    password: ENV['APP_PASS'],
    authentication: ENV['SMTP_AUTHENTICATION'],
    enable_starttls_auto: true
  }
end

def send_email_notification(from, to, subject, content, file = nil)
  Mail.new do
    from     from
    to       to
    subject  subject
    html_part do
      content_type 'text/html; charset=UTF-8'
      body content
    end
    add_file file if file && File.exist?(file)
  end
end
