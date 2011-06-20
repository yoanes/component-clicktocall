# Generic steps that should apply to any webapp.

When /^I am using an? "([^"]+?)"$/ do |device_name|
  begin
    driver_name = "selenium_" + device_name
    Capybara.current_driver = driver_name.to_sym
  rescue
    raise "No driver registered for symbol #{driver_name.to_sym}. Supported drivers: #{Capybara.drivers}. If you need more, configure them in env.rb (for now)."
  end

  @device = $devices[device_name]
end

When /^the "([^"]+?)" page should be displayed$/ do |page_name|
  page_model_class_name = page_name + "PageModel"
  begin
    @page_model = Pages.const_get(page_model_class_name).new(page)
  rescue
    raise $!, "Could not instantiate class with name of #{page_model_class_name}." , $!.backtrace
  end

  @page_model.should be_valid
end

When /^the "([^"]+?)" page should be displayed for "([^"]+?)"$/ do |page_name, logical_data_item|
  page_model_class_name = page_name + "PageModel"
  begin
    @page_model = Pages.const_get(page_model_class_name).new(page, logical_data_item)
  rescue
    raise $!, "Could not instantiate class with name of #{page_model_class_name}." , $!.backtrace
  end

  @page_model.should be_valid
end


When /^I click .* link "([^"]+?)"$/ do |link|
  click_link link
end

When /^I click .* link for "([^"]+?)"$/ do |logical_data_item|
  click_link @page_model.data[logical_data_item].link_text
end

When /^the system should log "([^"]+?)"$/ do |log_string|
  @log_deltas.should have_unique(log_string)
end

When /^the system should( not)? log .* for "([^"]+?)"$/ do |boolean, logical_data_item|
  expected = !boolean
  if (expected)
    @log_deltas.should have_unique(@page_model.data[logical_data_item].log_string)
  else
    @log_deltas.should_not have_unique(@page_model.data[logical_data_item].log_string)
  end
end

When /^I wait for "(\d+?)" seconds$/ do |wait_seconds|
  puts "Waiting for #{wait_seconds.to_i} seconds ... "
  sleep wait_seconds.to_i
end
