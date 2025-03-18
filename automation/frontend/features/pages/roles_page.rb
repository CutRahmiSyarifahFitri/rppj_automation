class RolesPage < SitePrism::Page
  include Capybara::DSL
  
  set_url '/roles'  # URL halaman pencarian setelah login

  element :logo, :xpath, "//div[@class='text-h5 font-weight-bold' and contains(text(), 'Roles')]"
  element :btn_peran, :xpath, "//span[@class='v-btn__content' and text()='Peran']"
  element :btn_addnew, :xpath, "//button[span[contains(., 'New Role')]]"
  element :input_namaperan, :xpath, "//input[@placeholder='Masukkan Nama Role']"
  element :checklist_dasbor, :xpath, "//span[@class='v-btn__content' and @data-no-activator='']//i[contains(@class, 'mdi-chevron-down') and contains(@class, 'v-icon')]"
  element :btn_switch, :xpath, "//div[@class='v-switch__track']"
  element :btn_simpan, :xpath, "//span[@class='v-btn__content' and @data-no-activator='' and text()='Simpan']"
  element :filter_namaperan, :xpath, "//input[@placeholder='Nama Peran']"
  element :filter_daftarakses, :xpath, "//input[@placeholder='Daftar Akses']"
  element :status_dropdown, :xpath, "//div[@class='v-field__append-inner']/i[contains(@class, 'mdi-menu-down')]"
  element :pilih_status, :xpath, "//span[@class='v-select__selection-text' and text()='Tidak Aktif']"
  element :btn_edit, :xpath, "(//button[contains(@class, 'v-btn') and contains(@class, 'v-btn--elevated') and contains(@class, 'v-btn--icon') and contains(@class, 'v-theme--light')])[3]"
  element :role_name_input, :xpath, "//input[@placeholder='Masukkan Nama Role' and @type='text']"
  element :btn_edit_save, :xpath, "//span[@class='v-btn__content' and @data-no-activator and text()='Simpan']"
  element :btn_notif_save, :xpath, "//span[@class='v-btn__content' and @data-no-activator and text()='Ya, Simpan Perubahan Role']"
  element :notif_success, :xpath, "//div[contains(@class, 'v-snackbar__content')]"

  
  # def dashboard_checklist
  # def select_dashboard_checklist
  #   p 'User is selecting the dashboard checklist checkbox'
  #   checklist_dasbor.set(true)  # Pastikan menggunakan nama elemen yang benar
  # end
end
