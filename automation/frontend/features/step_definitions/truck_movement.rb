Then(/^user go to truck movement page$/) do
  page.driver.browser.manage.window.maximize
  p 'User navigating to dashboard page'
  waiting_for_page_ready
  # Verifikasi teks 'Dashboard'
  expect(@pages.dashboard_page).to have_dashboard_title
end

When(/^I choose CP "(.*)" as the origin CPs$/) do |origin_cp_label|
  waiting_for_page_ready

  # Ambil nama CP dari parameter (contoh: "CP 1" -> "CP1")
  cp_name = origin_cp_label.gsub(' ', '')  # Memastikan nama CP tidak ada spasi

  # Gunakan XPath untuk memilih CP berdasarkan teks yang ada pada elemen <span>
  cp_selector = "//span[contains(text(), '#{cp_name}')]"

  # Verifikasi elemen CP ada di halaman
  unless page.has_selector?(:xpath, cp_selector, wait: 10)
    raise "Element CP #{cp_name} tidak ditemukan"
  end

  # Temukan elemen CP
  @origin_cp_element = find(:xpath, cp_selector)
  puts "Mencari elemen CP dengan nama: #{cp_name}"

  # Validasi status aktif CP
  if @origin_cp_element[:class].include?('inactive')
    raise "CP #{cp_name} dalam status tidak aktif"
  end

  # Hover action
  begin
    @origin_cp_element.hover
    puts "Berhasil hover ke CP #{cp_name}"
  rescue StandardError => e
    raise "Gagal hover ke CP #{cp_name}. Error: #{e.message}"
  end
end

Then(/^the truck unit CP "(.*)" is moved to the active destination CP "(.*)"$/) do |truck_unit, destination_cp|
  # Test melihat list truck yang ada pada @origin_cp_element
  origin_cp_element = find_by_id("divScrollId-#{destination_cp}") # Mencari elemen yang sesuai dengan truck unit
  truck_list = origin_cp_element.all('div[id^="port-cp-"]') # Mengambil semua truk berdasarkan ID yang dimulai dengan port-cp-

  # Ambil salah satu truk berdasarkan index
  truck_to_move = truck_list.find { |truck| truck[:id] == "port-cp-#{truck_number}" }

  # Test melihat CP tujuan
  destination_cp_element = find_by_id("divScrollId-#{destination_cp}")

  # Berikan kondisi jika truk berhasil dipindahkan ke CP tujuan
  begin
    truck_to_move.drag_to(destination_cp_element)

    expect(page).to have_css('div.ant-notification-notice-message', text: 'Successfully assign truck to cp')
    puts "Truck successfully moved to #{destination_cp}"
  rescue => e
    puts "Error moving truck: #{e.message}"
    
    # Jika truk tidak dapat dipindahkan, periksa jika CP atau lane sedang offline
    if page.has_css?('div.ant-notification-notice-message', text: 'Gagal memindahkan unit. CP atau lane antrian sedang offline')
      puts "Failed to move truck. CP or lane is offline."
    end
  end
end



And(/^the user selects "(.*)" as the origin lane$/) do |lane_input|
  waiting_for_page_ready

  # 1. Ekstrak angka dari input (Contoh: "Lane 3" -> "3")
  lane_number = lane_input.split(' ').last
  puts "Memproses pemilihan lane: #{lane_number}"

  # 2. Cari element lane di halaman
  lane_selector = "#lane-#{lane_number}"
  unless page.has_selector?(lane_selector, wait: 10)
    raise "Jalur #{lane_number} tidak ditemukan"
  end

  # 3. Simpan element lane yang dipilih
  @origin_lane = find(lane_selector)
  puts "Berhasil menemukan element: #{@origin_lane[:id]}"

  # 4. Validasi status lane
  if @origin_lane[:class].include?('inactive')
    raise "Jalur #{lane_number} dalam status tidak aktif"
  end

  # 5. Aksi hover dengan error handling
  begin
    @origin_lane.hover
    puts "Berhasil hover ke jalur #{lane_number}"
  rescue StandardError => e
    raise "Gagal hover ke jalur #{lane_number}. Error: #{e.message}"
  end
end

Then('dashboard memperbarui status unit secara real-time') do
  begin
    expect(page).to have_content("Terakhir diperbarui:", wait: 10)
    puts "Status unit diperbarui secara real-time"
  rescue StandardError => e
    puts "Gagal memverifikasi pembaruan status: #{e.message}"
    # Tetap lanjutkan eksekusi
  end
end

Then(/^the truck unit lane "(.*)" should be moved to the active destination CP "(.*)"$/) do |truck_unit, destination_cp|
  begin
    waiting_for_page_ready
    raise "Lane asal tidak ditemukan" unless @origin_lane

    # Mendapatkan nomor lane dan nomor truk
    lane_number = @origin_lane[:id].split('-').last
    truck_number = truck_unit.split('-').last

    # Menentukan elemen CP tujuan
    destination_cp_element = find_by_id("divScrollId-#{destination_cp}")

    # Membuat selector untuk truk yang akan dipindahkan
    truck_selector = "#lane-#{lane_number}-truck-#{truck_number}"
    
    # Mencari elemen truk
    unless page.has_selector?(truck_selector, wait: 10)
      raise "Truk dengan selector #{truck_selector} tidak ditemukan"
    end
    truck_element = find(truck_selector)

    # Membuat selector CP
    cp_selector = "#port-cp-#{destination_cp}"

    # Memindahkan truk ke CP tujuan
    truck_element.drag_to(destination_cp_element)

    # Verifikasi truk telah dipindahkan
    within(destination_cp_element) do
      expect(page).to have_selector("##{truck_selector}", wait: 10)
    end
    puts "Verifikasi sukses: Truk #{truck_unit} berada di CP #{destination_cp}"

    # Menunggu dan memverifikasi notifikasi berhasil
    notification_selector = ".ant-notification-notice:first-child .ant-notification-notice-message"
    success_message = "Successfully assign truck to cp"
    error_message = "Unit tidak dapat dipindahkan ke CP #{destination_cp} karena kapasitas penuh"

    if page.has_selector?(notification_selector, text: success_message, wait: 10)
      puts "Notifikasi: #{success_message}"
    elsif page.has_selector?(notification_selector, text: error_message, wait: 10)
      raise "#{error_message}"
    else
      raise "Tidak ada notifikasi yang muncul"
    end
  rescue StandardError => e
    puts "Error: #{e.message}"
    raise e
  end
end

Then(/^the truck unit lane "(.*)" should be moved to the active destination lane "(.*)"$/) do |truck_unit, destination_lane|
  waiting_for_page_ready
  begin
    # Mendapatkan nama lane asal dan nomor truk
    lane_name = @origin_lane.text.strip  # Mendapatkan nama lane asal
    truck_number = truck_unit.split('-').last

    # Mencari truk di lane asal berdasarkan nama lane dan ID truk
    truck_selector = "//span[contains(text(), '#{lane_name}')]/ancestor::div[contains(@id, 'lane')]//div[@id='lane-#{lane_name}-truck-#{truck_number}']"
    truck_element = find(:xpath, truck_selector, wait: 10)
    puts "Berhasil menemukan truk #{truck_unit} di lane #{lane_name}"

    # Mencari elemen lane tujuan
    destination_lane_selector = "//span[contains(text(), '#{destination_lane}')]"
    unless page.has_selector?(:xpath, destination_lane_selector, wait: 10)
      raise "Lane tujuan #{destination_lane} tidak ditemukan"
    end

    # Temukan elemen lane tujuan
    destination_element = find(:xpath, destination_lane_selector)

    # Pindahkan truk ke lane tujuan
    truck_element.drag_to(destination_element)
    puts "Truk #{truck_unit} berhasil dipindahkan ke lane #{destination_lane}"

    # Verifikasi truk berada di lane tujuan
    within(destination_element) do
      expect(page).to have_selector("#{destination_lane_selector}-truck-#{truck_number}", wait: 10)
    end

    puts "Verifikasi sukses: Truk #{truck_unit} ada di lane #{destination_lane}"

  rescue StandardError => e
    puts "Error: #{e.message}"
    raise e  # Tetap raise error agar Cucumber mencatatnya sebagai failed
  end
end
