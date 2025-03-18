Given(/^user set request header$/) do
  @api_handler ||= ApiHandler.new(ENV['BASE_URL_API'])
  @response_saver ||= ResponseSaver.new 
  @headers = { "Content-Type" => "application/json" }
  puts "ApiHandler initialized"
end

When(/^user sends a "(POST)" request to "(auth\/login)" with:$/) do |method, endpoint, table|
  payload = table.hashes.first
  @response = @api_handler.post(endpoint, payload)
  puts "Sent #{method} request to #{endpoint}"
  puts "Response Code: #{@response.code}" # Cetak kode respons
  puts "Response Body: #{@response.body}" # Cetak body respons  
end

# File: features/step_definitions/login-api.rb

Then(/^the response code should be "(.*)"$/) do |expected_code|
  # Validasi kode respons
  @api_handler.validate_response_code(@response, expected_code)
  @response_saver ||= ResponseSaver.new  

  # Ambil token dari response login
  login_response = JSON.parse(@response.body)
  $bearer_token = login_response['token'] # <-- Letakkan di sini

  # Debug: Pastikan token terambil
  puts "Token dari login: #{@bearer_token}"

  # Simpan response body ke file
  @response_saver.save_response_body(@response.body, "response_login-api_body.json")
end