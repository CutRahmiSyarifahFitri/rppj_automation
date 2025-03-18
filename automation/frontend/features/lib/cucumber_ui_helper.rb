# Module for UI helper
module CucumberUIHelper
  include Capybara::DSL

  def scroll_to_item(root_element, target_element)
    original_wait_time = change_capybara_wait_time(0.5)

    max_scroll_reached = false
    check_element = "has_#{target_element}?"
    is_menu_visible = send(check_element)

    begin
      scroll_until_element_visible(root_element, check_element, is_menu_visible, max_scroll_reached)
    ensure
      Capybara.default_max_wait_time = original_wait_time
    end
  end

  private

  def change_capybara_wait_time(wait_time)
    original_wait_time = Capybara.default_max_wait_time
    Capybara.default_max_wait_time = wait_time
    original_wait_time
  end

  def scroll_until_element_visible(root_element, check_element, is_menu_visible, max_scroll_reached)
    until is_menu_visible || max_scroll_reached
      scroll_down(root_element)
      is_menu_visible = send(check_element)
      max_scroll_reached = max_scroll_reached?(root_element)
      break if is_menu_visible || max_scroll_reached
    end
  end

  def scroll_down(root_element)
    page.execute_script('arguments[0].scrollBy(0, 100);', root_element)
  end

  def max_scroll_reached?(root_element)
    current_scroll_position = page.evaluate_script('arguments[0].scrollTop', root_element.native)
    max_scroll_height = page.evaluate_script('arguments[0].scrollHeight', root_element.native)
    client_height = page.evaluate_script('arguments[0].clientHeight', root_element.native)
    current_scroll_position >= (max_scroll_height - client_height)
  end
end

World(CucumberUIHelper)
