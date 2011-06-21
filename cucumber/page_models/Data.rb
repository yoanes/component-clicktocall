module Pages
  module Data
    def self.init_data

      data = {}
      data["a phone number"] = PhoneNumber.new("clicktocall-ph0", "(03) 9001 0001", "+61390010001", 
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61390010001' - in a real app, reporting would occur here ...")
      data["another phone number"] = PhoneNumber.new("clicktocall-ph1", "(03) 9001 0002", "+61390010002",
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61390010002' - in a real app, reporting would occur here ...")
      data["WPM iphone scrapable phone number"] = PhoneNumber.new("phoneNumber", "(02) 7001 0002", "+61270010002",
                                                "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} \
- AJAX reporting call for phone number '+61270010002' - in a real app, reporting would occur here ...")
      data
    end

    class PhoneNumber
      attr_accessor :container_id, :link_text, :call_formatted_number, :log_string

      def initialize(container_id, link_text, call_formatted_number, log_string)
        @container_id = container_id
        @link_text = link_text
        @call_formatted_number = call_formatted_number
        @log_string = log_string
      end

      def href(device)
        "#{device.call_link_protocol_string}#{@call_formatted_number}"
      end
    end

  end

  DATA = Data.init_data
end
