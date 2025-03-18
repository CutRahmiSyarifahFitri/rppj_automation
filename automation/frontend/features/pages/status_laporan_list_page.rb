require_relative 'global_section'

# `DashboardPage`` class serves as a container for dashboard page objects
class StatusLaporanListPage < SitePrism::Page
  set_url '/reportstatus'

  section :navbar, NavbarSection,
          '#inspire header'

  section :date_picker, DatePickerSection, :xpath, "//div[contains(@class, 'dp__outer_menu_wrap')]"

  element :page_title, :xpath, "//div[@class='text-h5 font-weight-bold']"

  section :table_status_laporan, '.v-table__wrapper table' do
    element :column_header_tanggal, 'thead tr:first-of-type th:nth-child(1)'
    element :column_header_id, 'thead tr:first-of-type th:nth-child(2)'
    element :column_header_judul, 'thead tr:first-of-type th:nth-child(3)'
    element :column_header_ketidaksesuaian, 'thead tr:first-of-type th:nth-child(4)'
    element :column_header_lokasi, 'thead tr:first-of-type th:nth-child(5)'
    element :column_header_status_hazard, 'thead tr:first-of-type th:nth-child(6)'
    element :column_header_status_validasi, 'thead tr:first-of-type th:nth-child(7)'

    element :filter_tanggal, 'tbody tr:first-of-type td:nth-child(1)'
    element :input_filter_tanggal, :xpath, "//input[@data-test='dp-input']"

    element :filter_judul, 'tbody tr:first-of-type td:nth-child(2)'
    element :filter_type_judul_deskripsi, 'tbody tr:first-of-type td:nth-child(2) .v-select__selection'
    element :input_filter_judul, 'tbody tr:first-of-type td:nth-child(2) input.v-field__input'

    element :filter_ketidaksesuaian, 'tbody tr:first-of-type td:nth-child(3)'
    element :input_filter_ketidaksesuaian, 'tbody tr:first-of-type td:nth-child(3) input'

    element :filter_lokasi, 'tbody tr:first-of-type td:nth-child(4)'
    element :filter_type_lokasi, 'tbody tr:first-of-type td:nth-child(4) .v-select__selection'
    element :input_filter_lokasi, 'tbody tr:first-of-type td:nth-child(2) input.v-field__input'

    element :filter_status_hazard, 'tbody tr:first-of-type td:nth-child(5)'
    element :filter_type_status_hazard, 'tbody tr:first-of-type td:nth-child(5) .v-select__selection'
    element :input_filter_status_hazard, 'tbody tr:first-of-type td:nth-child(5) div.v-field__input input:nth-child(1)'

    element :filter_status_validasi, 'tbody tr:first-of-type td:nth-child(6)'
    element :input_filter_status_validasi, 'tbody tr:first-of-type td:nth-child(6) input'

    elements :list_tanggal, 'tbody tr:nth-of-type(n+2) td:nth-child(1)'
    elements :list_id, 'tbody tr:nth-of-type(n+2) td:nth-child(2)'
    elements :list_judul, 'tbody tr:nth-of-type(n+2) td:nth-child(3)'
    elements :list_ketidaksesuaian, 'tbody tr:nth-of-type(n+2) td:nth-child(4)'
    elements :list_lokasi, 'tbody tr:nth-of-type(n+2) td:nth-child(5)'
    elements :list_status_hazard, 'tbody tr:nth-of-type(n+2) td:nth-child(6)'
    elements :list_status_validasi, 'tbody tr:nth-of-type(n+2) td:nth-child(7)'

    element :btn_search, '#btn-do-search'
  end

  elements :filter_options, 'div.v-list-item__content'

  def select_options(option_name)
    waiting_for_page_ready
    filter_options.find { |item| item.text == option_name }.click
  end
end
