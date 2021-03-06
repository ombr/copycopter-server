require 'timeout'

module VerifyWithTimeout
  def verify_with_timeout(selector, failure_message)
    Timeout::timeout(5) do
      page.has_css?(selector) && yield(find(selector))
    end
  rescue Timeout::Error
    if page.has_css?(selector)
      raise failure_message
    else
      raise "Couldn't find #{selector}"
    end
  end
end

World VerifyWithTimeout

