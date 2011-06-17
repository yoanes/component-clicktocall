When /^I am using an? "([^"]+?)"$/ do |device_name|
  begin
    driver_name = "selenium_" + device_name
    Capybara.current_driver = driver_name.to_sym
  rescue
    raise "No driver registered for symbol #{driver_name.to_sym}. Supported drivers: #{Capybara.drivers}."
  end
end

When /^I click .* link "([^"]+?)"$/ do |link|
  click_link link
end

When /^the system logs "([^"]+?)"$/ do |log_string|
  @log_deltas.should have_unique(log_string)
end

