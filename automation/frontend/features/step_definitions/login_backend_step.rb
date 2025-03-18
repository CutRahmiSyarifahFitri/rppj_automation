Given(/^user logged in using "(.*)" credentials$/) do |user_type_details|
  @user_type_details = user_type_details
  @data_login = @load_data.login_requirement.load_secret_details(user_type_details)

  url = URI("#{ENV['BASE_URL_API']}/auth/login")
  request_url = url.to_s
  headers = { 'Content-Type' => 'application/json' }
  body = {
    username: @data_login['username'],
    password: @data_login['password'].to_s,
    rememberMe: false
  }.to_json
  begin
    response = RestClient::Request.execute(
      method: :post,
      url: request_url,
      headers:,
      payload: body,
      timeout: 120,
      open_timeout: 120
    )
  rescue RestClient::Exception => e
    response = e.response
  end
  @response = Response.create response if response
end

Then(/^user successfully logged in$/) do
  expect(@response.get('$..data.token')).not_to be_nil

  user_actions = {
    'super_admin' => lambda {
      expect(@response.get('$..email')).to eq @data_login['username']
      expect(@response.get('$..name')).to eq @data_login['name']
    }
  }

  if user_actions.key?(@user_type_details)
    user_actions[@user_type_details].call
  else
    puts "No specific action for user #{@user_type_details}"
  end
end
