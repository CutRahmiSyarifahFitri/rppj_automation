require_relative 'global_section'

class CrudSimpangBayahLanePage < SitePrism::Page
  set_url 'admin/lane-gate-master-data'

  # Element untuk judul halaman
  element :page_title, :xpath, "//div[contains(@class, 'flex') and contains(@class, 'flex-row') and contains(@class, 'text-xl') and contains(@class, 'font-bold')]"

# Button "Tambah Lane"
  element :add_lane_button, 'button.ant-btn.ant-btn-primary.ant-btn-dangerous', text: 'Tambah Lane'
  # Form Modal Tambah Lane
  element :lane_name_input, 'input#form_item_lane_name'
  element :lane_order_dropdown, 'div.ant-select-selector'
  element :operational_status_toggle, 'button.ant-switch-small'
  element :reason_textarea, 'textarea#form_item_reason_status'
  element :lane_order_option, 'div.ant-select-item'

  # Button Simpan pada modal
  element :save_button, 'button span', text: 'Simpan'
  element :success_notification, 'div.ant-notification-notice-message'

  # Button Batal pada modal
  element :cancel_button, 'button span', text: 'Batal'
  # Dropdown container element for scrolling
  element :dropdown_scroll_container, 'div.rc-virtual-list-holder', visible: true
  element :dropdown_container, 'div.ant-select-dropdown'
  elements :dropdown_options, 'div.ant-select-item-option-content'

  def dropdown_option(text:)
    find('div.ant-select-item-option', text: text)
  end
# Error message
  element :lane_name_error, 'div.ant-form-item-explain-error'

  # tombol edit
  elements :edit_buttons, :xpath, "//button[contains(@class, 'ant-btn-dangerous') and .//img[contains(@class, 'w-5') and contains(@class, 'h-5')]]"
  element :ubah_nama_lane, '#form_item_lane_name'


end
