require_relative 'global_section'

# `CheckPointPage``
class CheckPoint < SitePrism::Page
  set_url 'admin/port-master-data'
  element :cp_title, :css, "div.font-bold.text-xl"
  element :add_cp_button, :xpath, "//button[span[text()='Tambah CP']]"
  element :cp_name_input, :xpath, "//input[@placeholder='Masukkan Nama CP']"
  # Elemen-elemen lainnya
  element :cp_order_dropdown, :css, "div.ant-select.ant-select-in-form-item.css-19iuou.ant-select-single.ant-select-show-arrow"
  element :dropdown_list, :css, "div.ant-select-dropdown"
  element :unit_type_dropdown, :css, "input#form_item_positioning.ant-select-selection-search-input"
  # Elemen dropdown "Urutan CP"
  element :cp_order_dropdown, :xpath, "//div[@class='ant-select ant-select-in-form-item css-19iuou ant-select-single ant-select-show-arrow']"
  # Elemen list item dalam dropdown "Urutan CP"
  elements :cp_order_options, :xpath, "//div[contains(@class, 'ant-select-item-option')]"
  
  def select_unit_type(cp_order)
    # Klik pada dropdown untuk membuka daftar
    cp_order_dropdown.click
  
    # Tunggu hingga daftar opsi muncul
    find("div.ant-select-item-option", wait: 10)
    # Pilih opsi berdasarkan nilai
    find(:xpath, "//div[contains(@class, 'ant-select-item-option') and @title='#{cp_order}']").click
  end


end
 
