require 'selenium-webdriver'

module Devices

  def self.create_iphone_profile
    profile = Selenium::WebDriver::Firefox::Profile.from_name "selenium-profile"
    profile['general.useragent.override'] = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_1 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8B117 Safari/6531.22.7"
    profile['general.description.override'] = "Mozilla" # appCodeName
    profile['general.appname.override'] = "Netscape"
    profile['general.appversion.override'] = "5.0 (iPhone; U; CPU iPhone OS 4_1 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8B117 Safari/6531.22.7"
    profile['general.platform.override'] = "iPhone"
    profile['general.useragent.vendor'] = "Apple Computer, Inc." 
    profile['general.useragent.vendorSub'] = ""   
    profile
  end

  def self.create_nokia6120_profile
    profile = Selenium::WebDriver::Firefox::Profile.from_name "selenium-profile"
    profile['general.useragent.override'] = "Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 Nokia6120c/3.83; Profile/MIDP-2.0 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413"
    profile['general.description.override'] = "Mozilla" # appCodeName
    profile
  end

end
