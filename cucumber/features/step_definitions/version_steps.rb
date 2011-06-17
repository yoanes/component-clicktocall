require "#{File.dirname(__FILE__)}/../../page_models/VersionPageModel.rb"

When /^the system shows the "([^"]+?)" page$/ do |page_name|
  page_model_class_name = page_name + "PageModel"
  begin
    page_model = Pages.const_get(page_model_class_name).new(page)
  rescue
    raise $!, "Could not instantiate class with name of #{page_model_class_name}." , $!.backtrace
  end

  page_model.should be_valid
end
