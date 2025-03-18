And('Saya memilih cp {string} sebagai cp asal') do |origin_cp|
  @origin_cp = origin_cp # Simpan nilai CP agar bisa digunakan di langkah berikutnya

  wait_for_loading_to_complete

  cp_xpath = "//div[contains(@id, 'port-cp-#{origin_cp.downcase}')]"

  puts "🔍 Mencari elemen CP dengan XPath: #{cp_xpath}"
  puts "📜 HTML saat ini:"
  puts page.html

  begin
    expect(page).to have_selector(:xpath, cp_xpath, wait: 15)
    puts "✅ CP #{origin_cp} ditemukan dan dipilih sebagai CP asal."
  rescue RSpec::Expectations::ExpectationNotMetError
    save_screenshot("debug_cp_#{origin_cp}.png", full: true)
    raise
  end
end

And('Saya diberitahu bahwa cp {string} aktif dan mempunyai list unit truck') do |origin_cp|

  cp_truck_list_xpath = "//div[contains(@id, 'port-cp-#{origin_cp.downcase}')]//div[contains(@id, 'port-cp-#{origin_cp.downcase}-truck')]"

  puts "🔍 Mencari daftar truk dengan XPath: #{cp_truck_list_xpath}"
  puts "📜 HTML saat ini:"
  puts page.html

  begin
    expect(page).to have_selector(:xpath, cp_truck_list_xpath, wait: 15)
    puts "✅ CP #{origin_cp} memiliki unit truk yang siap untuk dumping."
  rescue RSpec::Expectations::ExpectationNotMetError
    save_screenshot("debug_truck_list_#{origin_cp}.png", full: true)
    raise
  end
end

And('Saya memilih unit truck {int} untuk diselesaikan dumping') do |index_truck|
  truck_xpath = "(//div[contains(@id, 'port-cp-#{@origin_cp.downcase}-truck')])[#{index_truck}]"

  puts "🔍 Mencari truk dengan XPath: #{truck_xpath}"
  puts "📜 HTML saat ini:"
  puts page.html

  begin
    expect(page).to have_selector(:xpath, truck_xpath, wait: 15)

    truck_name = find(:xpath, "#{truck_xpath}//strong").text
    puts "✅ Truk #{truck_name} di CP #{@origin_cp} pada index #{index_truck} dipilih untuk dumping."

    dumping_button_xpath = "#{truck_xpath}//button[contains(@class, 'ant-btn-dangerous')]"
    find(:xpath, dumping_button_xpath).click
  rescue RSpec::Expectations::ExpectationNotMetError
    save_screenshot("debug_truck_#{@origin_cp}_index_#{index_truck}.png", full: true)
    raise
  end
end

Then('Saya melihat pop-up konfirmasi untuk truk di index {int} di CP {string}') do |index_truck, origin_cp|
  popup_xpath = "//div[contains(@class, 'ant-modal-confirm-body')]"

  begin
    expect(page).to have_selector(:xpath, popup_xpath, wait: 15)

    truck_name_xpath = "(//div[contains(@id, 'port-cp-#{origin_cp.downcase}-truck')]//strong)[#{index_truck}]"
    truck_name = find(:xpath, truck_name_xpath).text

    message_xpath = "//div[contains(@class, 'ant-modal-confirm-body')]//*[contains(text(), '#{truck_name}') and contains(text(), '#{origin_cp}')]"
    expect(page).to have_selector(:xpath, message_xpath)

    puts "✅ Pop-up konfirmasi muncul untuk truk #{truck_name} di CP #{origin_cp}."
  rescue RSpec::Expectations::ExpectationNotMetError
    save_screenshot("debug_popup_#{origin_cp}_index_#{index_truck}.png", full: true)
    raise
  end
end

And('Saya menekan tombol Ya untuk menyelesaikan dumping') do
  ya_button_xpath = "//button[contains(@class, 'ant-btn-dangerous') and span[text()='Ya']]"
  
  begin
    expect(page).to have_selector(:xpath, ya_button_xpath, wait: 15)
    find(:xpath, ya_button_xpath).click
    puts "✅ Tombol 'Ya' ditekan untuk menyelesaikan dumping."
  rescue RSpec::Expectations::ExpectationNotMetError
    save_screenshot("debug_confirm_button.png", full: true)
    raise
  end
end

Then('Unit truk tersebut hilang dari cp {string}') do |origin_cp|
  truck_xpath = "//div[contains(@id, 'port-cp-#{origin_cp.downcase}-truck')]"

  begin
    expect(page).to have_no_selector(:xpath, truck_xpath, wait: 15)
    puts "✅ Truk berhasil dihapus dari CP #{origin_cp} setelah dumping selesai."
  rescue RSpec::Expectations::ExpectationNotMetError
    save_screenshot("debug_truck_removed_#{origin_cp}.png", full: true)
    raise
  end
end
