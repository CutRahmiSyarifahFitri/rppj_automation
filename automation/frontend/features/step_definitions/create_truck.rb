require 'securerandom'
require_relative 'D:\hello\rppj_automation\automation\frontend\features\lib\api_handler.rb'


Given('the user sets the authentication token in the header') do
  # Log untuk memverifikasi token sebelum menggunakannya di header
  puts "Token sebelum setting header: #{@bearer_token}"

  if @bearer_token.nil?
    raise "Token tidak ditemukan. Pastikan login berhasil dan token sudah disimpan."
  end

  # Inisialisasi ApiHandler dengan token otentikasi
  @api_handler.set_headers({ 'Authorization' => "Bearer #{@bearer_token}" })  # Menyertakan token pada header
  @response_saver ||= ResponseSaver.new
  puts "Request header set with Bearer token"
end

When('the user gets the request body template from {string}') do |filename|
  # Perbarui path untuk mencari file di folder `schemas`
  path_body = "#{Dir.pwd}/schemas/#{filename}"
  raise "File not found: #{path_body}" unless File.file?(path_body)

  @body = JSON.parse(File.read(path_body))
  puts "Request body template loaded from: #{filename}"
end

When('the user sets the request body for {string} create with dynamic values') do |entity|
  1.times do
    @request_body = {}

    # Generate ID unik dengan 5 angka acak
    @request_body['id'] = SecureRandom.random_number(10000..99999)

    # Generate nomor lambung dinamis dengan 3 huruf acak dan 4 angka acak
    random_letters = Array('A'..'Z').sample(3).join
    random_numbers = SecureRandom.random_number(1000..9999)
    @request_body['nomor_lambung'] = "#{random_letters}-#{random_numbers}"

    # Nilai dinamis lainnya
    @request_body['capacity_in_tons'] = rand(10..20) # Nilai dinamis untuk kapasitas
    @request_body['year_made'] = rand(2000..2020) # Nilai dinamis untuk tahun pembuatan
    @request_body['status'] = [true, false].sample # Nilai dinamis untuk status
    @request_body['model'] = "Model#{rand(1..10)}" # Nilai dinamis untuk model
    @request_body['brand'] = "Brand#{rand(1..10)}" # Nilai dinamis untuk brand
    @request_body['vendor'] = "Vendor#{rand(1..10)}" # Nilai dinamis untuk vendor
    @request_body['typeoftruck'] = ['DDT','ST','DT'].sample # Nilai dinamis untuk jenis truk

    # Pastikan tipe data sesuai dengan skema
    @request_body['id'] = @request_body['id'].to_i
    @request_body['capacity_in_tons'] = @request_body['capacity_in_tons'].to_i
    @request_body['year_made'] = @request_body['year_made'].to_i
    @request_body['status'] = @request_body['status'].to_s == 'true'
    @request_body['model'] = @request_body['model'].to_s
    @request_body['brand'] = @request_body['brand'].to_s
    @request_body['vendor'] = @request_body['vendor'].to_s
    @request_body['typeoftruck'] = @request_body['typeoftruck'].to_s

    # Output atau simpan @request_body sesuai kebutuhan Anda
    puts @request_body
  end
end

When('the user sends a {string} request to {string}') do |method, endpoint|
  # Debugging: Print the state of @api_handler
  puts "@api_handler: #{@api_handler.inspect}"
  
  # Ensure @api_handler is initialized
  @api_handler ||= ApiHandler.new(ENV['BASE_URL_API'])
  
  puts "Token: #{$bearer_token}"  # Debugging: Print the token
  puts "Headers: #{@headers}"     # Debugging: Print the headers
  @response = @api_handler.post(endpoint, @request_body)
  puts "Response Code: #{@response.code}"
  puts "Response Body: #{@response.body}"
end

Then('the create truck response code should be {string}') do |expected_code|
  @api_handler.validate_response_code(@response, expected_code)
  puts "Create truck response code is #{expected_code}"
end

And('the JSON response should follow schema {string}') do |schema|
  file_path = "#{Dir.pwd}/features/schemas/#{schema}"
  raise "Schema file not found: #{file_path}" unless File.file?(file_path)

  response_body = JSON.parse(@response.body)
  JSON::Validator.validate!(file_path, response_body)
  puts "JSON response validated against schema: #{schema}"
end

And('the user sets the authentication token from the login response') do
  # Parsing respons JSON dari login
  login_response = JSON.parse(@response.body)
  
  # Ambil token dari respons
  if login_response['data'] && login_response['data']['token']
    @bearer_token = login_response['data']['token'] 
    @headers['Authorization'] = "Bearer #{@bearer_token}"
    # Simpan token ke dalam variabel instance untuk digunakan di langkah berikutnya
    puts "Authentication token set from login response: #{@bearer_token}"
  else
    raise "Token tidak ditemukan dalam respons login!"
  end
end


And('save the response body') do
  # Tentukan folder berdasarkan kode respons
  status_folder = if @response.code.to_s == '200' || @response.code.to_s == '201'
                   'body/data/respc' # Folder untuk respons sukses
                 else
                   case @response.code.to_s
                   when '404' then 'failed_body/404'
                   when '400' then 'failed_body/400'
                   when '500' then 'failed_body/500'
                   else 'failed_body/other'
                   end
                 end

  # Buat folder jika belum ada
  FileUtils.mkdir_p(status_folder) unless Dir.exist?(status_folder)

  # Generate unique filename using timestamp
  timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
  filename = "#{status_folder}/response_body_#{@response.code}_#{timestamp}.json"

  # Simpan response body ke file dengan nama unik
  @response_saver.save_response_body(@response.body, filename)
  puts "@ Response saved to #{filename}"
end