Then('the user navigates to the simpang bayah lane master data') do
  waiting_for_page_ready
  @pages.crud_simpang_bayah_lane_page.load
  @pages.crud_simpang_bayah_lane_page.wait_until_page_title_visible
  expect(@pages.crud_simpang_bayah_lane_page.page_title.text).to eq('Master Data Simpang Bayah')
end

And('I click the "Add Lane" button') do
  #@crud_simpang_bayah_lane_page = CrudSimpangBayahLanePage.new
  @pages.crud_simpang_bayah_lane_page.add_lane_button.click(wait: 10)
end 

Then('I fill in the "Lane Name" with {string}') do |lane_name|
  @pages.crud_simpang_bayah_lane_page.lane_name_input.set(lane_name)
  # Verifikasi apakah error muncul jika input kosong  
  if lane_name.strip.empty?
    expect(@pages.crud_simpang_bayah_lane_page).to have_lane_name_error
    error_message = @pages.crud_simpang_bayah_lane_page.lane_name_error.text
    raise "Validation error displayed: #{error_message}" if error_message.include?('Kolom nama Lane wajib diisi')
  end
end

Then('I select the "Lane Order" as {string}') do |lane_order|
  waiting_for_page_ready
  # Buka dropdown jika belum terbuka
  @pages.crud_simpang_bayah_lane_page.dropdown_container.click
  # Tunggu elemen dropdown muncul
  expect(@pages.crud_simpang_bayah_lane_page).to have_dropdown_scroll_container
  # Scroll dalam dropdown container untuk memastikan elemen terlihat
  execute_script("arguments[0].scrollTop = arguments[0].scrollHeight", @pages.crud_simpang_bayah_lane_page.dropdown_scroll_container.native)
# Pilih elemen sesuai input
  @pages.crud_simpang_bayah_lane_page.dropdown_option(text: lane_order).click
  if lane_order.strip.empty?
    expect(@pages.crud_simpang_bayah_lane_page).to have_lane_order_error
    error_message = @pages.crud_simpang_bayah_lane_page.lane_order_error.text
    raise "Validation error displayed: #{error_message}" if error_message.include?('Kolom urutan CP wajib diisi')
  end
end

Then('I toggle "Operational Status" to {string}') do |status|
  expected_state = (status == 'aktif') ? 'true' : 'false'
  toggle_state = @pages.crud_simpang_bayah_lane_page.operational_status_toggle['aria-checked'] != expected_state
  @pages.crud_simpang_bayah_lane_page.operational_status_toggle.click if toggle_state
  puts "Toggling status to #{status}" if toggle_state

end

Then('I enter the "Reason" as {string}') do |reason|
  @pages.crud_simpang_bayah_lane_page.reason_textarea.set(reason)
end

And('I click the simpan button') do
  waiting_for_page_ready
  @pages.crud_simpang_bayah_lane_page.save_button.click(wait: 10)

  # Tunggu notifikasi muncul
  if @pages.crud_simpang_bayah_lane_page.has_success_notification?(wait: 10)
    # Verifikasi isi notifikasi
    success_message = @pages.crud_simpang_bayah_lane_page.success_notification.text
    unless success_message.include?('Data was saved successfully')
      raise "Unexpected success message: #{success_message}"
    end
    puts "Notification found: #{success_message}"
  else
    raise "Notification not found!"
  end
end

# Langkah untuk klik tombol edit berdasarkan index
When('user clicks the Edit button index {int}') do |index|
  waiting_for_page_ready
  @pages.crud_simpang_bayah_lane_page.edit_buttons[index].click
  # Verifikasi modal "Ubah Lane" muncul
  expect(page).to have_selector('.ant-modal-content', text: 'Ubah Lane')

end

# Step untuk update data berdasarkan field dan nilai baru
And('I update the record {string} to {string}') do |field, new_value|
  waiting_for_page_ready
  case field
  when 'lane_name'
    @pages.crud_simpang_bayah_lane_page.lane_name_input.set(new_value)
  when 'lane_order'
    @pages.crud_simpang_bayah_lane_page.lane_order_dropdown.click(wait: 10)
    find('div.ant-select-item-option', text: new_value).click(wait: 10)
  when 'status'
    expected_state = (new_value == 'aktif') ? 'true' : 'false'
    toggle_state = @pages.crud_simpang_bayah_lane_page.operational_status_toggle['aria-checked'] != expected_state
    @pages.crud_simpang_bayah_lane_page.operational_status_toggle.click if toggle_state
  when 'reason'
    @pages.crud_simpang_bayah_lane_page.reason_textarea.set(new_value)
  else
    raise "Field #{field} not recognized!"
  end
end










