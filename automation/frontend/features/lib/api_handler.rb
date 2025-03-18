require 'net/http'
require 'uri'
require 'json'

class ApiHandler
  def initialize(base_url, bearer_token = nil)
    @base_url = base_url
    @headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    
    # Menambahkan Bearer Token ke header jika token tersedia
    if bearer_token
      @headers['Authorization'] = "Bearer #{bearer_token}"
    end
  end

  # Method untuk mengatur header tambahan, termasuk Authorization jika perlu
  def set_headers(headers)
    @headers.merge!(headers)
  end

  # Method untuk mengirim request POST
  def post(endpoint, body)
    uri = URI("#{@base_url}/#{endpoint}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https') # Aktifkan SSL jika URL menggunakan https

    request = Net::HTTP::Post.new(uri.path, @headers)

    # 🔍 Debugging: Print Header & Body
    puts "➡️ Sending POST request to: #{uri}"
    puts "Headers: #{@headers}"
    puts "Request Body: #{body.to_json}"

    request.body = body.to_json

    response = http.request(request)
    response
  end

  # Method untuk validasi response code
  def validate_response_code(response, expected_code)
    if response.code.to_i == expected_code.to_i
      puts "✅ Response code: #{response.code}"
    else
      raise "❌ Expected response code #{expected_code}, but got #{response.code}"
    end
  end

  # Helper method untuk generate ID unik (4 digit)
  def generate_unique_id
    # Generate angka acak antara 1000 dan 9999
    rand(1000..9999)
  end

  # Helper method untuk generate nomor lambung unik (3 huruf)
  def generate_unique_nomor_lambung
    # Generate 3 huruf acak dari A-Z
    chars = ('A'..'Z').to_a
    Array.new(3) { chars.sample }.join
  end
end
