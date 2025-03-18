When(/^user get request body template from "(.*?).(yml|json)"$/) do |filename, extension|
  path_body = "#{Dir.pwd}/features/body/#{filename}.#{extension}"

  raise %(File not found: '#{path_body}') unless File.file? path_body

  case extension
  when 'yml'
    @body = YAML.safe_load File.open(path_body)
  when 'json'
    @body = JSON.parse File.read(path_body)
  else
    raise %(Unsupported file type: '#{path_body}')
  end
end

Given(/^user set request header$/) do
  @headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
    Authorization: @bearer_token,
    'Authorization-esb': @token_esb
  }
end

When(/^user set authentication token$/) do
  @bearer_token = @response.get('$..token')
  @token_esb = @response.get('$..token_esb')
  step 'user set request header'
end

Given(/^user applies filter with "judul" as "(.*?)"$/) do |judul_filter|
  # Menyusun filter berdasarkan judul
  @filters = {
    'judul' => judul_filter
  }

  # Menyimpan filter untuk digunakan dalam request
  @request_filters = @filters
end

Then(/^the response code should be "(.*)"$/) do |status_code|
  expect(@response.code).to eq status_code.to_i
end

Then(/^the JSON response should follow schema "(.*?).(yml|json)"$/) do |schema, extension|
  file_path = "#{Dir.pwd}/features/schemas/#{schema}.#{extension}"
  if File.file? file_path
    begin
      JSON::Validator.validate!(file_path, @response.to_s)
    rescue JSON::Schema::ValidationError
      raise JSON::Schema::ValidationError.new(%(#{$ERROR_INFO.message}\n#{@response.to_json_s}),
                                              $ERROR_INFO.fragments, $ERROR_INFO.failed_attribute, $ERROR_INFO.schema)
    end
  else
    p %(WARNING: missing schema '#{file_path}')
    pending
  end
end

Then(/^the JSON response should have "(.*)" with type "(.*)" and value "(.*)" "(.*)"$/) do |json_path, type, comparison_type, value|
  if value.start_with? '@'
    # get value from instance variable
    value = instance_variable_get(value.to_s)
  elsif value.include? 'txt'
    # get value from localization
    value = I18n.t(value.to_s)
  end
  p "==> value: #{value}"
  expect(@response.get_as_type_and_check_value(json_path, type, comparison_type, resolve(value))).to eq true
end

When(/^user send a "(.*)" request to "(.*)"$/) do |method, path|
  url = URI("#{ENV['BASE_URL_API']}/#{path}")
  request_url = url.to_s
  if (method == 'GET') && $cache.key?(request_url.to_s)
    @response = $cache[request_url.to_s]
    @headers = nil
    @body = nil
    next
  end
  p "==> body #{@body}"
  @headers = {} if @headers.nil?
  retries = 0
  p "==> headers #{@headers}"
  begin
    begin
      response =  case method
                  when 'GET'
                    RestClient::Request.execute(method: :get, url: request_url, headers: @headers, payload: @body, timeout: 120, open_timeout: 120)
                  when 'POST'
                    RestClient.post request_url, @body, @headers
                  when 'PATCH'
                    RestClient.patch request_url, @body, @headers
                  when 'PUT'
                    RestClient.put request_url, @body, @headers
                  else
                    RestClient.delete request_url, @headers
                  end
    rescue RestClient::Exception => e
      response = e.response
    end
    @response = Response.create response
    expect(response.nil?).to eq false
  rescue StandardError => e
    raise e.message if (retries += 1) == 5

    p e.message
    retry
  end

  p "==> response body #{@response}"
  @headers = nil
  @body = nil
  $cache[request_url.to_s] = @response if method.to_s == 'GET'
end

When(/^user send a "(.*)" request to "(.*)" with:$/) do |method, url, params|
  p "====: method #{method}"
  p "====: url #{url}"
  p "====: params #{params}"
  url = "#{ENV['BASE_URL_API']}/#{url}"
  unless params.hashes.empty?
    query = params.hashes.first.map { |key, value| value[0] == '@' ? %(#{key}=#{instance_variable_get(value)}) : %(#{key}=#{value}) }.join('&')
    request_url = url.include?('?') ? %(#{url}&#{query}) : %(#{url}?#{query})
  end
  p "====: request_url #{request_url}"
  @headers = {} if @headers.nil?

  retries ||= 0
  begin
    begin
      response = case method
                 when 'GET'
                   RestClient::Request.execute(method: :get, url: request_url, headers: @headers, payload: @body, timeout: 120, open_timeout: 120)
                 when 'POST'
                   RestClient.post request_url, @body, @headers
                 when 'PATCH'
                   RestClient.patch request_url, @body, @headers
                 when 'PUT'
                   RestClient.put request_url, @body, @headers
                 else
                   RestClient.delete request_url, @headers
                 end
    rescue RestClient::Exception => e
      response = e.response
    end

    expect(response.nil?).to eq false
  rescue StandardError => e
    p e.message
    retry if (retries += 1) < 5
    raise e.message if retries == 5
  end

  @response = Response.create response
  @headers = nil
  @body = nil
  $cache[request_url.to_s] = @response if method.to_s == 'GET'
  p "==> response body #{@response}"
end

When(%r{^user sends a "GET" request to "api/esb/insting/list-data" with$}) do
  # Mengirimkan permintaan GET dengan filter yang telah diterapkan
  @response = send_get_request_with_filters(@request_filters)
end
