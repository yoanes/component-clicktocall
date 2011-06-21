require 'selenium-webdriver'

module Devices

  FIREFOX_PROFILE_NAME = "selenium-profile"

  class Device
    attr_accessor :name, :profile, :call_link_protocol_string

    def initialize(name)
      @name = name
      @call_link_protocol_string = "tel:"
    end
  end

  def self.iphone4_1
    device = Device.new("iphone4_1")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_1 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8B117 Safari/6531.22.7"
    profile['general.description.override'] = "Mozilla" # appCodeName
    profile['general.appname.override'] = "Netscape"
    profile['general.appversion.override'] = "5.0 (iPhone; U; CPU iPhone OS 4_1 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8B117 Safari/6531.22.7"
    profile['general.platform.override'] = "iPhone"
    profile['general.useragent.vendor'] = "Apple Computer, Inc." 
    profile['general.useragent.vendorSub'] = ""   
    device.profile = profile

    device
  end

  def self.iphone3_1
    device = Device.new("iphone3_1")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_1_3 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7E18 Safari/528.16"
    profile['general.description.override'] = "Mozilla" # appCodeName
    profile['general.appname.override'] = "Netscape"
    profile['general.appversion.override'] = "5.0 (iPhone; U; CPU iPhone OS 3_1_3 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7E18 Safari/528.16"
    profile['general.platform.override'] = "iPhone"
    profile['general.useragent.vendor'] = "Apple Computer, Inc." 
    profile['general.useragent.vendorSub'] = ""   
    device.profile = profile

    device
  end

  def self.htc_desire
    device = Device.new("htc_desire")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "Mozilla/5.0 (Linux; U; Android 2.1-update1; en-au; HTC_Desire_A8183 V1.15.841.13 Build/ERE27) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17"
    device.profile = profile

    device
  end

  def self.nokia6120
    device = Device.new("nokia6120")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 Nokia6120c/3.83; Profile/MIDP-2.0 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML, like Gecko) Safari/413"
    device.profile = profile

    device.call_link_protocol_string = "wtai://wp/mc;"

    device
  end

  def self.nokiaN95
    device = Device.new("nokiaN95")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "Mozilla/5.0 (SymbianOS/9.2; U; Series60/3.1 NokiaN95-3/10.2.006; Profile/MIDP-2.0 Configuration/CLDC-1.1) AppleWebKit/413 (KHTML/ like Gecko) Safari/413px"
    device.profile = profile

    device.call_link_protocol_string = "wtai://wp/mc;"

    device
  end

  def self.samsungC5220
    device = Device.new("samsungC5220")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "SAMSUNG-C5220/1.0 SHP/VPP/R5 NetFront/3.4 Qtv5.3 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1"
    device.profile = profile

    device.call_link_protocol_string = "wtai://wp/mc;"

    device
  end

  def self.samsungA411
    device = Device.new("samsungA411")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "SAMSUNG-SGH-A411/1.0 SHP/VPP/R5 NetFront/3.3 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1 UP.Link/6.5.1.3.0"
    device.profile = profile

    device
  end

  def self.thub
    device = Device.new("thub")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    profile['general.useragent.override'] = "Opera/9.70 (Linux armv6l ; U; HomeManager/HSV4.0/1.04Q; en) Presto/2.2.1"
    device.profile = profile

    device
  end

  def self.pc_firefox
    device = Device.new("pc_firefox")

    profile = Selenium::WebDriver::Firefox::Profile.from_name FIREFOX_PROFILE_NAME
    device.profile = profile

    device.call_link_protocol_string = ""

    device
  end

end
