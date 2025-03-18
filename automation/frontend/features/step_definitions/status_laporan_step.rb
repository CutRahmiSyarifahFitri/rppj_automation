Given(/^user go to status laporan page$/) do
  waiting_for_page_ready
  expect(@pages.status_laporan_list_page).to have_navbar
  @pages.status_laporan_list_page.navbar.menu_status_laporan.click
end

Given(/^user is on status laporan list page$/) do
  waiting_for_page_ready
  expect(@pages.status_laporan_list_page.page_title.text).to eq 'Status Laporan'
  expect(@pages.status_laporan_list_page).to have_table_status_laporan
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_tanggal
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_id
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_judul
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_ketidaksesuaian
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_lokasi
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_status_hazard
  expect(@pages.status_laporan_list_page.table_status_laporan).to have_column_header_status_validasi
end

Given(/^users "(.*)" filter by "(.*)" with "(.*)"$/) do |scenario, filter, data|
  waiting_for_page_ready
  case filter
  when 'judul'
    @pages.status_laporan_list_page.table_status_laporan.filter_type_judul_deskripsi.click
    @pages.status_laporan_list_page.select_options('Judul')
    @pages.status_laporan_list_page.table_status_laporan.input_filter_judul.set(data)
  end
  @pages.status_laporan_list_page.table_status_laporan.btn_search.click
  waiting_for_page_ready

  case scenario
  when 'success'
    expect(@pages.status_laporan_list_page.table_status_laporan.list_judul.all? { |item| item.text.include?(data) }).to be true
  end
end

Given(/^user "(.*)" filter by "(.*)" with "(.*)"$/) do |scenario, filter, data|
  waiting_for_page_ready

  filter_mappings = {
    'tanggal' => {
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_tanggal,
      filter_action: lambda do |data_tanggal|
        start_datetime, end_datetime = data_tanggal.split(' - ')
        start_date, start_time = start_datetime.split
        end_date, end_time = end_datetime.split

        @pages.status_laporan_list_page.table_status_laporan.input_filter_tanggal.click
        start_hour, start_minute = start_time.split(':')
        @pages.status_laporan_list_page.date_picker.select_date(0, start_date, start_hour, start_minute)

        @pages.status_laporan_list_page.table_status_laporan.input_filter_tanggal.click
        end_hour, end_minute = end_time.split(':')
        @pages.status_laporan_list_page.date_picker.select_date(1, end_date, end_hour, end_minute)

        @pages.status_laporan_list_page.table_status_laporan.input_filter_tanggal.click
      end,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_tanggal }
    },
    'judul' => {
      filter_element: @pages.status_laporan_list_page.table_status_laporan.filter_type_judul_deskripsi,
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_judul,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_judul }
    },
    'deskripsi' => {
      filter_element: @pages.status_laporan_list_page.table_status_laporan.filter_type_judul_deskripsi,
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_judul,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_judul }
    },
    'ketidaksesuaian' => {
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_ketidaksesuaian,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_ketidaksesuaian }
    },
    'perusahaan_pelapor' => {
      filter_element: @pages.status_laporan_list_page.table_status_laporan.filter_type_judul_deskripsi,
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_ketidaksesuaian,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_ketidaksesuaian }
    },
    'status_hazard' => {
      filter_element: @pages.status_laporan_list_page.table_status_laporan.filter_type_status_hazard,
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_status_hazard,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_status_hazard }
    },
    'tipe_resiko' => {
      filter_element: @pages.status_laporan_list_page.table_status_laporan.filter_type_status_hazard,
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_status_hazard,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_status_hazard }
    },
    'status_validasi' => {
      input_element: @pages.status_laporan_list_page.table_status_laporan.input_filter_status_validasi,
      validation_list: -> { @pages.status_laporan_list_page.table_status_laporan.list_status_validasi }
    }
  }

  filter_details = filter_mappings[filter]

  if filter == 'tanggal'
    filter_details[:filter_action].call(data)
    waiting_for_page_ready

    start_date_str, end_date_str = data.split(' - ')
    start_date = Date.parse(start_date_str)
    end_date = Date.parse(end_date_str)
  else
    filter_details[:filter_element]&.click
    @pages.status_laporan_list_page.select_options(filter.split('_').map(&:capitalize).join(' ')) unless %w[tanggal ketidaksesuaian status_validasi].include?(filter)
    filter_details[:input_element].set(data)
  end

  @pages.status_laporan_list_page.table_status_laporan.btn_search.click
  waiting_for_page_ready

  case scenario
  when 'success'
    if filter == 'tanggal'

      expect(
        filter_details[:validation_list].call.all? do |item|
          item_date = Date.parse(item.text)
          item_date >= start_date && item_date <= end_date
        end
      ).to be true

    elsif scenario == 'success'
      expect(filter_details[:validation_list].call.all? { |item| item.text.include?(data) }).to be true
    end
  end
end
