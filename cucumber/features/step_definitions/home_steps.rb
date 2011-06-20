When /^I have visited the Home page$/ do
  url = get_prop "base_url"  
  url << "/" if url.reverse[0].chr != "/"
  visit url + "home.action"
  @log_analyser = LogAnalyser.new(get_prop "log_files")
  @page_model = Pages::HomePageModel.new(@device, page)
  @page_model.should be_valid
end

When /^the Home page has the expected phone number links$/ do
  @page_model.should have_phone_number_links
end

When /^the Home page has no phone number links$/ do
  @page_model.should have_no_phone_number_links
end

