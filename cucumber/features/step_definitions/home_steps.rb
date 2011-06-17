When /^the device uses a click to call prefix of "([^"]+?)"$/ do |click_to_call_protocol_prefix|
  @click_to_call_protocol_prefix = click_to_call_protocol_prefix
end

When /^I have accessed the showcase home page$/ do
  url = get_prop "base_url"  
  url << "/" if url.reverse[0].chr != "/"
  visit url + "home.action"
  page.should have_link('(03) 9001 0001', { :href => "#{@click_to_call_protocol_prefix}+61390010001"})
  page.should have_link('(03) 9001 0002', { :href => "#{@click_to_call_protocol_prefix}+61390010002"})
  page.should have_link('(02) 7001 0002', { :href => "#{@click_to_call_protocol_prefix}+61270010002"})
  @log_analyser = LogAnalyser.new(get_prop "log_files")
end      

When /^the device phone dialler should be executed for "([^"]+?)"$/ do |phone_href|
  @log_deltas = @log_analyser.new_deltas
  @log_deltas.should have_unique("au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.TelephoneProtocolHandlerAction {} - TelephoneProtocolHandlerAction invoked for href: '#{phone_href}'")
end
