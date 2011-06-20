# Common steps that can be applied to multiple features in the current web app. Unlike generic_steps.rb, these steps
# may not necessarily be useful to other web apps.

When /^the device phone dialler should be executed for "([^"]+?)"$/ do |logical_phone_number|
  @log_deltas = @log_analyser.new_deltas(get_prop("log_analyser_wait_seconds"))
  @log_deltas.should have_unique("au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.TelephoneProtocolHandlerAction {} - TelephoneProtocolHandlerAction invoked for href: '#{@page_model.data[logical_phone_number].href}'")
end
