And('saya klik icon pensil') do
  @pages.ubah_nomor_lambung.click_edit_icon
end

Then('saya mengubah nomor lambung {string}') do |nomor_lambung_baru|
  @pages.ubah_nomor_lambung.change_truck_number(nomor_lambung_baru)
end

And('saya klik tombol simpan') do
  @pages.ubah_nomor_lambung.click_save_button
end
