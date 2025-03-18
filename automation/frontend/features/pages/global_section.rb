# Global Section handles all the section that appears on almost every page
class NavbarSection < SitePrism::Section
  element :navbar, :xpath,
          "//nav[contains(@class, 'w-[290px] relative z-[51]')]"

  element :btn_home, :xpath,
          "//a[@href='/reportvalidation']//img[@alt='Vuetify Logo']"

  element :menu_dashboard, :xpath,
          "//a//span[contains(text(), 'Dashboard')]"

  element :menu_manajemen_truck, :xpath,
          "//a//span[contains(text(), 'Manajemen Truck')]"

  element :menu_cp_master_data, :xpath,
          "//a//span[contains(text(), 'CP Master Data')]"

  element :menu_manajement_user, :xpath,
          "//a//span[contains(text(), 'Manajemen User')]"

  element :text_greeting_name, :xpath,
          "//button[contains(.,'Hai,')]"

  def scroll_to_see_menu(menu_element)
    scroll_to_item(sidebar, menu_element)
  end
end

# DatePickerSection
class DatePickerSection < SitePrism::Section
  section :dp_dialog, :xpath, "//div[@role='dialog' and contains(@class, 'dp__menu')]" do
    element :dp_prev_arrow, :xpath, "//button[@data-dp-element='action-prev' and @aria-label='Previous month']"
    element :dp_next_arrow, :xpath, "//button[@data-dp-element='action-next' and @aria-label='Next month']"

    elements :dp_grid_cels, 'div.dp__overlay_col'

    element :dp_month, :xpath, "//button[@data-dp-element='overlay-month' and @data-test='month-toggle-overlay-0']"
    element :dp_year, :xpath, "//button[@data-dp-element='overlay-year' and @data-test='year-toggle-overlay-0']"
    elements :dp_date_items, :xpath, "//div[@class='dp__calendar_item']"

    element :dp_time_picker_btn, :xpath, "//button[@data-test='open-time-picker-btn']"
    element :dp_date_select_btn, :xpath, "//button[contains(@class, 'dp__action_select')]"
  end

  def select_date(index, date_str, hour, minutes)
    year, month, day = date_str.split('/').map(&:to_i)
    select_year(year)
    select_month(month)
    select_day(year, month, day)
    select_time(index, hour, minutes)
  end

  def select_year(year)
    dp_dialog.dp_year.click
    dp_dialog.dp_grid_cels.find { |item| item.text == year.to_s }.click
  end

  def select_month(month)
    dp_dialog.dp_month.click
    months = { 1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'May', 6 => 'Jun',
               7 => 'Jul', 8 => 'Aug', 9 => 'Sep', 10 => 'Oct', 11 => 'Nov', 12 => 'Dec' }
    dp_dialog.dp_grid_cels.find { |item| item.text == months[month] }.click
  end

  def select_day(year, month, day)
    find(:xpath, "//div[@id='#{year}-#{format('%02d', month)}-#{format('%02d', day)}']").click
  end

  def select_time(index, hours, minutes)
    dp_dialog.dp_time_picker_btn.click
    hours_toggle(index).click
    find(:xpath, "//div[@role='gridcell' and @data-test='#{hours}']").click

    minutes_toggle(index).click
    find(:xpath, "//div[@role='gridcell' and @data-test='#{minutes}']").click

    dp_dialog.dp_date_select_btn.click
  end

  def hours_toggle(index)
    find(:xpath, "//button[@data-test='hours-toggle-overlay-btn-#{index}']")
  end

  def minutes_toggle(index)
    find(:xpath, "//button[@data-test='minutes-toggle-overlay-btn-#{index}']")
  end
end
