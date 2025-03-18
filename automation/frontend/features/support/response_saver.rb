require 'json'
require 'fileutils'

class ResponseSaver
  def initialize(base_directory = File.join(Dir.pwd, 'features', 'body', 'data'))
    @base_directory = base_directory
  end
  
  def save_response_body(response_body, filename)
    File.write(filename, response_body)
  end

  # Method untuk menyimpan response body ke file
  def save_response_body(response_body, filename)
    # Buat direktori jika belum ada
    FileUtils.mkdir_p(@base_directory) unless Dir.exist?(@base_directory)

    # Path lengkap ke file
    file_path = File.join(@base_directory, filename)

    begin
      # Coba parse response body sebagai JSON
      parsed_body = JSON.parse(response_body)
      File.open(file_path, 'w') do |file|
        file.write(JSON.pretty_generate(parsed_body))
      end
      puts "✅ Response body saved to: #{file_path}"
    rescue JSON::ParserError => e
      # Jika response body bukan JSON, simpan sebagai plain text
      puts "❌ Failed to parse response body: #{e.message}"
      File.open(file_path, 'w') do |file|
        file.write(response_body)
      end
      puts "✅ Response body saved as plain text to: #{file_path}"
    end
  end
end