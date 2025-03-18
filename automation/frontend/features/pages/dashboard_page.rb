# `DashboardPage`
class DashboardPage < SitePrism::Page
  set_url 'admin/dashboard'

  section :navbar, NavbarSection, 'nav'

  element :dashboard_title, :xpath, "//h4[contains(text(), 'Dashboard')]"

  # Elemen CP (berdasarkan nama CP, bukan ID)
  elements :cp_elements, :xpath, "//span[contains(text(), 'CP')]"

  # Elemen Lane (Jalur)
  elements :lane_elements, '[id^="lane-"]'
  #elemen truk
  
end
