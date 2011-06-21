require 'spec/expectations'

module Pages
  class CallingPageModel
    # Use Rspec magic.
    include Spec::Expectations
    include Spec::Matchers
    
    def initialize(device, capybara_page, phone_number)
      @device = device
      @capybara_page = capybara_page
      @phone_number = phone_number
    end

    def valid?
      @capybara_page.should have_xpath('//img[@class = "callingIcon" and contains(@src, "calling.gif")]')
      @capybara_page.should have_link("Nothing Happened? - Try again", { :href => "#{@phone_number.href(@device)}" })
      @capybara_page.should have_content("Display formatted number: #{@phone_number.link_text}")
      @capybara_page.should have_content("Call formatted number: #{@phone_number.call_formatted_number}")
    end

  end
end
