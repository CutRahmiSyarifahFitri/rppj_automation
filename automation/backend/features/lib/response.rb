# Extension of {RestClient::Response} with support for JSON path traversal and validation
module Response
  # Create a Response with JSON path support
  # @param response [RestClient::Response] original response
  # @return [Response] self
  def self.create(response)
    result = response
    result.extend Response
    result
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue JSON::ParserError
    false
  end

  # Check if given JSON path exists
  # @param json_path [String] a valid JSON path expression
  # @param json [String] optional JSON from which to check JSON path, default to response body
  # @return [true, false] true if JSON path is valid and exists, false otherwise
  def has(json_path, json = nil)
    json = JSON.parse body if json.nil?
    !JsonPath.new(json_path).on(json).empty?
  end

  # Retrieve value of the first JSON element with given JSON path
  # @param json_path [String] a valid JSON path expression
  # @param json [String] optional JSON from which to apply JSON path, default to response body
  # @return [Object] value of first retrieved JSON element in form of Ruby object
  # @raise [Exception] if JSON path is invalid or no matching JSON element found
  def get(json_path, json = nil)
    json = JSON.parse body if json.nil?
    results = JsonPath.new(json_path, { allow_send: false }).on(json)

    results.empty? ? nil : results.first
  end

  # Retrieve value of the first JSON element with given JSON path as given type
  # @param json_path [String] a valid JSON path expression
  # @param type [String] required type, possible values are 'numeric', 'array', 'string', 'boolean', 'numeric_string'
  # or 'object'
  # @param json [String] optional JSON from which to apply JSON path, default to response body
  # @return [Object] value of first retrieved JSON element in form of given type
  # @raise [Exception] if JSON path is invalid or no matching JSON element found or matching element does not match
  # required type
  def get_as_type(json_path, type, json = nil)
    value = get(json_path, json)
    case type
    when 'numeric'
      valid = value.is_a? Numeric
    when 'array'
      valid = value.is_a? Array
    when 'string'
      valid = value.is_a? String
    when 'boolean'
      valid = [true, false].include? value
    when 'numeric_string'
      (valid = value.is_a?(Numeric)) || value.is_a?(String)
    when 'object'
      valid = value.is_a? Hash
    when 'null'
      valid = value.is_a? NilClass
    else
      raise %(Invalid expected type '#{type}')
    end

    raise %(Expect '#{json_path}' as a '#{type}' but was '#{value.class}'\n#{to_json_s}) unless valid

    value
  end

  # Retrieve value of the first JSON element with given JSON path as given type, with nil value allowed
  # @param json_path [String] a valid JSON path expression
  # @param type [String] required type, possible values are 'numeric', 'array', 'string', 'boolean', 'numeric_string'
  # or 'object'
  # @param json [String] optional JSON from which to apply JSON path, default to response body
  # @return [Object] value of first retrieved JSON element in form of given type or nil
  # @raise [Exception] if JSON path is invalid or no matching JSON element found or matching element does not match
  # required type
  def get_as_type_or_null(json_path, type, json = nil)
    value = get json_path, json
    value.nil? ? value : get_as_type(json_path, type, json)
  end

  # Retrieve value of the first JSON element with given JSON path as given type, and check for a given value
  # @param json_path [String] a valid JSON path expression
  # @param type [String] required type, possible values are 'numeric', 'string', 'boolean', or 'numeric_string'
  # @param value [String] value to check for
  # @param json [String] optional JSON from which to apply JSON path, default to response body
  # @return [Object] value of first retrieved JSON element in form of given type or nil
  # @raise [Exception] if JSON path is invalid or no matching JSON element found or matching element does not match
  # required type or value
  def get_as_type_and_check_value(json_path, type, comparison_type, value, json = nil)
    v = get_as_type(json_path, type, json)

    case comparison_type
    when 'equal'
      raise %(Expect '#{json_path}' to be '#{value}' but was '#{v}'\n#{to_json_s}) if value != v.to_s

      v.to_s == value
    when 'not equal'
      raise %(Expect '#{json_path}' not to be '#{value}' but was '#{v}'\n#{to_json_s}) if value == v.to_s

      v.to_s != value
    when 'include'
      raise %(Expect '#{json_path}' should include '#{value}' but was '#{v}'\n#{to_json_s}) unless v.include?(value)

      v.include?(value)
    when 'between'
      # define vstart and vend first
      range = (vstart..vend)
      raise %(Expect '#{json_path}' should between '#{vstart}' and '#{vend}' but was '#{v}'\n#{to_json_s}) unless range.include?(value)

      range.include?(value)
    end
  end

  # Retrieve pretty JSON response for logging
  # @return [String] pretty JSON response if verbose setting is true, empty string otherwise
  def to_json_s
    if ENV['cucumber_api_verbose'] == 'true'
      JSON.pretty_generate(JSON.parse(to_s))
    else
      ''
    end
  end

  def response_include_text(text, response)
    response = JSON.parse response if valid_json?(response)
    raise "no text #{text} inside #{response}" if (response.to_s.include? text).eql? false
  end

  RestClient::Response.send(:include, self)
end
