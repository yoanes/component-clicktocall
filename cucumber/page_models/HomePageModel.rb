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
        # Don't assert the value of the href. The actual value doesn't matter as long as clicking it has the desired effet.
        @capybara_page.should have_xpath("//div[@id='#{data_item.container_id}' and @class='callLink' and a = '#{data_item.link_text}']/a[@class='clickToCallLink']")
      end
    end

    def has_no_phone_number_links?
      @data.each_value do |data_item|
        @capybara_page.should have_xpath('//div[@id="clicktocall-ph0" and @class="callLink" and . = "(03) 9001 0001"]')
      end
    end

  end
end
