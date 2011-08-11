require 'spec/expectations'

module Pages
  class HomePageModel
    # Use Rspec magic.
    include Spec::Expectations
    include Spec::Matchers

    def initialize(device, capybara_page)
      @device = device
      @capybara_page = capybara_page

      @data = Pages::DATA
    end

    def valid?
      @capybara_page.should have_content('Phone and fax numbers')
    end

    def has_phone_number_links?
      i = 0
      @data.each_value do |data_item|
        @capybara_page.should have_xpath(data_item.phone_number_link_xpath)
      end
    end

    def has_no_phone_number_links?
      @data.each_value do |data_item|
        @capybara_page.should have_xpath(data_item.phone_number_no_link_xpath)
      end
    end

  end
end
