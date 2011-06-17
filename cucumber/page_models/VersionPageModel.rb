#require 'capybara/session'

module Pages
  class VersionPageModel
    def initialize(capybara_page)
      @capybara_page = capybara_page
    end

    def valid?
      @capybara_page.has_content?("Version")
      @capybara_page.has_content?("Platform:desk")
      @capybara_page.has_content?("Date:")
    end
  end
end
