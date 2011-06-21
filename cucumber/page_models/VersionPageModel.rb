require 'spec/expectations'

module Pages
  class VersionPageModel
    # Use Rspec magic.
    include Spec::Expectations
    include Spec::Matchers

    def initialize(device, capybara_page)
      @capybara_page = capybara_page
    end

    def valid?
      @capybara_page.should have_content("Version")
      @capybara_page.should have_content("Platform:desk")
      @capybara_page.should have_content("Date:")
    end
  end
end
