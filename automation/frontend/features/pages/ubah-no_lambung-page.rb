require_relative 'global_section'

# `UbahNomorLambungPage``
class UbahNomorLambungPage < SitePrism::Page

  # Navigasi ke halaman truck movement
  def visit_truck_movement_page
    visit '/truck-movement' # Sesuaikan dengan URL yang benar
    expect(page).to have_current_path('/truck-movement', ignore_query: true)
    puts "Berada di halaman Truck Movement."
  end

  # Klik ikon pensil untuk mengedit nomor lambung
  def click_edit_icon
    edit_button_xpath = "//button[contains(@class, 'ant-btn') and contains(@class, 'ant-btn-icon-only')]"
    find(:xpath, edit_button_xpath).click
    puts "Klik ikon pensil untuk mengedit nomor lambung."
  end

  # Mengubah nomor lambung dengan yang baru
  def change_truck_number(new_truck_number)
    input_xpath = "//input[@type='text' and contains(@class, 'ant-input')]"
    find(:xpath, input_xpath).set(new_truck_number)
    puts "Mengubah nomor lambung menjadi: #{new_truck_number}."
  end

  # Klik tombol simpan untuk menyimpan perubahan
  def click_save_button
    save_button_xpath = "//button[contains(@class, 'ant-btn-primary') and span[text()='Simpan']]"
    find(:xpath, save_button_xpath).click
    puts "Klik tombol simpan."
  end

  # Verifikasi apakah dashboard telah diperbarui
  def verify_dashboard_updated(new_truck_number)
    truck_xpath = "//strong[contains(text(), '#{new_truck_number}')]"
    expect(page).to have_selector(:xpath, truck_xpath)
    puts "Nomor lambung berhasil diubah, dashboard diperbarui secara real-time."
  end
end
