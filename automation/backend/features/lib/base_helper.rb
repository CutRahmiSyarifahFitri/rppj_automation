# Module base helper for common function
module BaseHelper
  def short_wait(time_out = SHORT_TIMEOUT)
    Selenium::WebDriver::Wait.new(
      timeout: time_out,
      interval: 0.2,
      ignore: Selenium::WebDriver::Error::NoSuchElementError,
      message: "element not found on the current screen after waiting #{time_out} seconds"
    )
  end

  def waiting_for_page_ready
    sleep 3
    wait_for_ajax
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      sleep 1 while finished_all_ajax_requests?.eql? false
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script(<<~EOS
      ((typeof window.jQuery === 'undefined')
       || (typeof window.jQuery.active === 'undefined')
       || (window.jQuery.active === 0))
      && ((typeof window.injectedJQueryFromNode === 'undefined')
       || (typeof window.injectedJQueryFromNode.active === 'undefined')
       || (window.injectedJQueryFromNode.active === 0))
      && ((typeof window.httpClients === 'undefined')
       || (window.httpClients.every(function (client) { return (client.activeRequestCount === 0); })))
    EOS
                        )
  end

  def resolve(url)
    url.gsub!(/\{([a-zA-Z0-9_]+)\}/) do |s|
      s.gsub!(/[\{\}]/, '')
      if instance_variable_defined?("@#{s}")
        CGI.escape %/#{instance_variable_get("@#{s}")}/
      else
        raise 'Did you forget to "grab" ' + s + '?'
      end
    end
    url
  end
end

World(BaseHelper)
