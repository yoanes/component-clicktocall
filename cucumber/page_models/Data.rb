module Pages
  module Data
    def self.init_data

      data = {}

      data["a phone number"] = PhoneNumber.new("clicktocall-ph0", "(03) 9001 0001", "+61390010001",  false,
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61390010001' - in a real app, reporting would occur here ...")

      data["another phone number"] = PhoneNumber.new("clicktocall-ph2", "(03) 9001 0002", "+61390010002", false,
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61390010002' - in a real app, reporting would occur here ...")

      data["WPM iphone scrapable phone number"] = PhoneNumber.new("phoneNumberWpm", "(02) 7001 0002", "+61270010002", true,
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61270010002' - in a real app, reporting would occur here ...")

      data
    end

    class PhoneNumber
      attr_accessor :container_id, :link_text, :call_formatted_number, :iphone_scrappable_wpm, :log_string

      def initialize(container_id, link_text, call_formatted_number, iphone_scrappable_wpm, log_string)
        @container_id = container_id
        @link_text = link_text
        @call_formatted_number = call_formatted_number
        @iphone_scrappable_wpm = iphone_scrappable_wpm
        @log_string = log_string
      end

      def href(device)
        "#{device.call_link_protocol_string}#{@call_formatted_number}"
      end

      def phone_number_link_xpath
        if (iphone_scrappable_wpm)
          # Don't assert the value of the href. The actual value doesn't matter as long as clicking it has the desired effet.
          "//div[@id='#{@container_id}' and @class='callLink']/a[@class='clickToCallLink']/span[@id='phoneNumber' and . = '#{@link_text}']"
        else
          # Don't assert the value of the href. The actual value doesn't matter as long as clicking it has the desired effet.
          "//div[@id='#{@container_id}' and @class='callLink']/a[@class='clickToCallLink' and . = '#{@link_text}']"
        end
      end

      def phone_number_no_link_xpath
        "//div[@id='#{@container_id}' and @class='callLink' and . = '#{@link_text}']"
      end
    end

  end

  DATA = Data.init_data
end
