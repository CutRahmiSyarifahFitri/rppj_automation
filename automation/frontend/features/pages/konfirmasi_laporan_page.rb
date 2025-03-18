#  KonfirmasiLaporanPage
class KonfirmasiLaporanPage < SitePrism::Page
  include Capybara::DSL

  set_url '/roles' # URL halaman pencarian setelah login

  element :tab_perlu_konfirmasi, '#tab-perlu-konfirmasi'
  element :counter_perlu_konfirmasi, '#tab-perlu-konfirmasi .v-chip__content'

  element :tab_valid, '#tab-valid'
  element :counter_valid, '#tab-valid .v-chip__content'

  element :tab_tidak_valid, '#tab-notvalid'
  element :counter_tidak_valid, '#tab-notvalid .v-chip__content'

  element :tab_hapus, '#tab-delete'
  element :counter_hapus, '#tab-delete .v-chip__content'

  elements :list_tanggal_aksi, '#row-created-at'

  elements :list_batas_perubahan, '#row-confirmation-deadline'

  elements :list_judul_deskripsi, '#row-title-description'
  element :input_filter_judul_deskripsi, '#filter-title'

  elements :list_kategori_resiko, '#row-risk'

  elements :list_pelapor, '#row-pelapor'
  element :input_filter_pelapor, '#filter-pelapor'

  elements :list_validator, '#row-requestor-validator'
  element :input_filter_validator, '#filter-requestor-validator'

  elements :list_tanggal_perubahan, '#row-updated-at'

  elements :list_btn_delete, '#btn-row-delete'
  elements :list_btn_not_valid, '#btn-row-notvalid'
  elements :list_btn_valid, '#btn-row-valid'

  element :input_item_per_page, '.v-data-table-footer__items-per-page .v-input__control'
  elements :list_item_per_page, '.v-list-item-title'

  element :btn_search, '#filter-dosearch'
  element :btn_reset_filter, '#filter-doreset'

  element :text_data_not_found, '.v-data-table-rows-no-data'

  element :btn_konfirmasi_laporan, :xpath, "//span[@class='v-btn__content' and @data-no-activator='']//text()[normalize-space(.)='Konfirmasi Laporan']/parent::span"
  element :btn_data_perlu_konfirmasi, :xpath, "//span[@class='v-btn__content']//div[@class='v-chip__content' and text()='0']"
  element :tab_konfirmasi_laporan_valid, :xpath, "//span[@class='v-btn__content']//div[@class='v-chip__content' and text()='6']"
  element :btn_data_tidak_valid, :xpath, "//span[@class='v-btn__content']//div[@class='v-chip__content' and text()='9']"
  element :btn_data_hapus, :xpath, "//span[@class='v-btn__content']//div[@class='v-chip__content' and text()='5']"

  element :output_filter_title, :xpath, "//div[text()='hazard test 23 oct 24']"

  element :output_filter_pelapor, :xpath, "//div[@id='row-pelapor' and @class='click' and contains(text(),'SISWONO')]"

  element :output_filter_validator, :xpath, "//div[text()='DIMAS [PROD] SUTEJO']"

  def select_options(option_list, option_name)
    waiting_for_page_ready
    option = option_list.find { |item| item.text.strip == option_name }
    raise "Option '#{option_name}' not found in the list." unless option

    option.click
  end

  def input_filter(filter_element, value)
    waiting_for_page_ready
    filter_element.set(value)
  end

  def verify_table_data(column_element, value)
    if column_element.any? { |item| item.text.include?(value) }
      item_found = true
    else
      p "Item #{value} not found. Retrying..."
    end
    item_found
  end
end
