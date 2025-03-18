require_relative 'global_section'

# `dumping-selesai-page`
class DumpingSelesai < SitePrism::Page

  # Menunggu sampai CP memiliki daftar unit truck
  def verify_cp_has_truck_list(cp_id)
    cp_xpath = "//div[contains(translate(@id, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'port-cp-#{cp_id.downcase}')]//div[contains(@id, 'port-cp-#{cp_id.downcase}-truck')]"
    expect(page).to have_selector(:xpath, cp_xpath, wait: 15)
    puts "CP #{cp_id} memiliki unit truck."
  end

  # Memilih truk berdasarkan indeks dalam CP
  def select_truck_by_index(cp_id, truck_index)
    truck_xpath = "(//div[contains(@id, 'port-cp-#{cp_id.downcase}-truck')])[#{truck_index}]"
    expect(page).to have_selector(:xpath, truck_xpath, wait: 15)

    truck_name = find(:xpath, "#{truck_xpath}//strong").text
    puts "Memilih truk #{truck_name} di CP #{cp_id} pada index #{truck_index}."

    # Klik tombol penyelesaian dumping
    dumping_button_xpath = "#{truck_xpath}//button[contains(@class, 'ant-btn-dangerous')]"
    find(:xpath, dumping_button_xpath).click
  end

  # Memverifikasi pop-up konfirmasi dumping muncul
  def verify_confirmation_popup(truck_name, cp_id)
    popup_xpath = "//div[contains(@class, 'ant-modal-confirm-body')]"
    message_xpath = "//div[contains(@class, 'ant-modal-confirm-body')]//*[contains(text(), '#{truck_name}') and contains(text(), '#{cp_id}')]"

    expect(page).to have_selector(:xpath, popup_xpath, wait: 15)
    expect(page).to have_selector(:xpath, message_xpath, wait: 15)
    puts "Pop-up konfirmasi muncul untuk truk #{truck_name} di CP #{cp_id}."
  end

  # Menekan tombol "Ya" pada konfirmasi dumping
  def confirm_dumping
    ya_button_xpath = "//button[contains(@class, 'ant-btn-dangerous') and span[text()='Ya']]"
    find(:xpath, ya_button_xpath, wait: 15).click
    puts "Tombol 'Ya' ditekan untuk menyelesaikan dumping."
  end

  # Memverifikasi truk telah hilang dari CP setelah dumping
  def verify_truck_removed(cp_id, truck_name)
    truck_xpath = "//div[contains(@id, 'port-cp-#{cp_id.downcase}-truck')]//strong[contains(text(), '#{truck_name}')]"
    expect(page).to have_no_selector(:xpath, truck_xpath, wait: 15)
    puts "Truk #{truck_name} telah hilang dari CP #{cp_id} setelah dumping."
  end
end
