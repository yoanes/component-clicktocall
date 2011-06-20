require 'spec/expectations'

module Pages
  class HomePageModel
    # Use Rspec magic.
    include Spec::Expectations
    include Spec::Matchers

    attr_accessor :data

    def initialize(device, capybara_page)
      @device = device
      @capybara_page = capybara_page

      @data = {}
      @data["a phone number"] = PhoneNumber.new("clicktocall-ph0", "(03) 9001 0001", "+61390010001", 
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61390010001' - in a real app, reporting would occur here ...", @device.call_link_protocol_string )
      @data["another phone number"] = PhoneNumber.new("clicktocall-ph1", "(03) 9001 0002", "+61390010002",
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61390010002' - in a real app, reporting would occur here ...", @device.call_link_protocol_string )
      @data["WPM iphone scrapable phone number"] = PhoneNumber.new("phoneNumber", "(02) 7001 0002", "+61270010002",
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61270010002' - in a real app, reporting would occur here ...", @device.call_link_protocol_string )
    end

    def valid?
      @capybara_page.should have_content('Phone and fax numbers')
    end

    def has_phone_number_links?
      i = 0
      @data.each_value do |data_item|
        @capybara_page.should have_xpath("//div[@id='#{data_item.container_id}' and @class='callLink' and a = '#{data_item.link_text}']/a[@class='clickToCallLink' and @href='#{data_item.href}']")
      end

      true
    end

    def has_no_phone_number_links?
      @data.each_value do |data_item|
        @capybara_page.should have_xpath('//div[@id="clicktocall-ph0" and @class="callLink" and . = "(03) 9001 0001"]')
      end
    end


    class PhoneNumber
      attr_accessor :container_id, :link_text, :call_formatted_number, :log_string, :call_link_protocol_string

      def initialize(container_id, link_text, call_formatted_number, log_string, call_link_protocol_string)
        @container_id = container_id
        @link_text = link_text
        @call_formatted_number = call_formatted_number
        @log_string = log_string
        @call_link_protocol_string = call_link_protocol_string
      end

      def href
        "#{@call_link_protocol_string}#{@call_formatted_number}"
      end
    end
  end
end
