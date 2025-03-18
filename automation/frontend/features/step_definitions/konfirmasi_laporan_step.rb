When(/^user on konfirmasi laporan page$/) do
  p 'User navigating to data perlu konfirmasi page'
  waiting_for_page_ready
  @pages.konfirmasi_laporan_page.btn_konfirmasi_laporan.click
  waiting_for_page_ready
end

When(/^user on "(.*)" tab on konfirmasi laporan page$/) do |scenario|
  waiting_for_page_ready

  case scenario
  when 'perlu_konfirmasi'
    @pages.konfirmasi_laporan_page.tab_perlu_konfirmasi.click
  when 'valid'
    @pages.konfirmasi_laporan_page.tab_valid.click
  when 'tidak_valid'
    @pages.konfirmasi_laporan_page.tab_tidak_valid.click
  when 'hapus'
    @pages.konfirmasi_laporan_page.tab_hapus.click
  end
end

Then(/^user verify tab "(.*)" counter and data on table match$/) do |scenario|
  waiting_for_page_ready
  @pages.konfirmasi_laporan_page.input_item_per_page.click
  @pages.konfirmasi_laporan_page.select_options(@pages.konfirmasi_laporan_page.list_item_per_page, 'All')

  case scenario
  when 'perlu_konfirmasi'
    counter = @pages.konfirmasi_laporan_page.counter_perlu_konfirmasi.text
  when 'valid'
    counter = @pages.konfirmasi_laporan_page.counter_valid.text
  when 'tidak_valid'
    counter = @pages.konfirmasi_laporan_page.counter_tidak_valid.text
  when 'hapus'
    counter = @pages.konfirmasi_laporan_page.counter_hapus.text
  end

  table_data_amount = @pages.konfirmasi_laporan_page.list_tanggal_aksi.count
  expect(counter.to_i).to eq table_data_amount.to_i
end

When(/^user filter by "(.*)" with value "(.*)"$/) do |filter_by, value|
  waiting_for_page_ready

  case filter_by
  when 'title'
    @pages.konfirmasi_laporan_page.input_filter(@pages.konfirmasi_laporan_page.input_filter_judul_deskripsi, value)
  when 'pelapor'
    @pages.konfirmasi_laporan_page.input_filter(@pages.konfirmasi_laporan_page.input_filter_pelapor, value)
  when 'validator'
    @pages.konfirmasi_laporan_page.input_filter(@pages.konfirmasi_laporan_page.input_filter_validator, value)
  end

  @pages.konfirmasi_laporan_page.btn_search.click
end

Then(/^user success verify filter result is correct from filter by "(.*)" with value "(.*)"$/) do |filter_by, value|
  waiting_for_page_ready

  case filter_by
  when 'title'
    item_found = @pages.konfirmasi_laporan_page.verify_table_data(@pages.konfirmasi_laporan_page.list_judul_deskripsi, value)
  when 'pelapor'
    item_found = @pages.konfirmasi_laporan_page.verify_table_data(@pages.konfirmasi_laporan_page.list_pelapor, value)
  when 'validator'
    item_found = @pages.konfirmasi_laporan_page.verify_table_data(@pages.konfirmasi_laporan_page.list_validator, value)
  end

  if item_found
    expect(item_found).to eq true
  else
    expect(@pages.konfirmasi_laporan_page.text_data_not_found.text).to include('Tidak ada data ditemukan')
  end
end
