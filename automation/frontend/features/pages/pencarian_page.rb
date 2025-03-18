require_relative 'global_section'

# `DashboardPage`` class serves as a container for dashboard page objects
class PencarianPage < SitePrism::Page
  set_url '/reportvalidation'

  section :navbar, NavbarSection,
          '#inspire header'
  element :input_keyword,
          'input[type="text"][deletable-chips]'
end
