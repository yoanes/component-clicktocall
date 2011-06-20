$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require "bundler/setup"
require 'spec/expectations'

#CAPYBARA
require 'capybara/cucumber'
require 'capybara/session'
require 'rainbow'
require 'yaml'
require 'ruby-debug';
require "#{File.dirname(__FILE__)}/devices.rb"

#selenium-webdriver
require 'selenium-webdriver'

# capybara <= 1.0.0.rc1 and/or selenium-webdriver <= 0.2.1 and flaky in firefox 4.x so we need to explicitly
# use firefox 3.6.x.
if !ENV["SENSIS_CAPYBARA_FIREFOX_PATH"].nil?
  puts "+_____________________________ BROWSER_PATH: #{ENV["SENSIS_CAPYBARA_FIREFOX_PATH"]} ___________________________+".underline.bright.background(:magenta)
  Selenium::WebDriver::Firefox.path = ENV["SENSIS_CAPYBARA_FIREFOX_PATH"]
end

$devices = {}
$devices[Devices::iphone.name] = Devices::iphone
$devices[Devices::nokia6120.name] = Devices::nokia6120
$devices[Devices::pc_firefox.name] = Devices::pc_firefox

def register_capybara_drivers
  $devices.each_value do |device|
    driver_name = "selenium_" << device.name
    Capybara.register_driver driver_name.to_sym do |app|  

      if ENV["DISABLE_COOKIES"]
        puts "_________________ Cookies have been Disabled___________".underline.bright.background(:magenta)
        device.profile['network.cookie.cookieBehavior'] = 2 # 0: enables ; 2: disable all
      else
        device.profile['network.cookie.cookieBehavior'] = 0 # 0: enables ; 2: disable all
      end

      # For capybara versions prior to '1.0.0.rc1'
      #Capybara::Driver::Selenium.new(app, :profile => profile)  
      # For capybara '1.0.0.rc1'
      Capybara::Selenium::Driver.new(app, :profile => device.profile)  
    end
  end
  
end

register_capybara_drivers
Capybara.default_driver = :selenium_iphone
Capybara.run_server = false
Capybara.default_wait_time = 7

#gizmo!!!
require 'gizmo'
World(Gizmo::Helpers)

Gizmo.configure do |config|
  # moved gizmo pages outside of support to be able to run cucumber dry-run for steps stats
  config.mixin_dir = File.dirname(__FILE__) + '/../../pages'  
  #config.mixin_dir =  "/home/leonardo/aajava/workspace/whereis-mobile/cucumber/pages"
end

# hooks after each step
AfterStep() do
  #Do whatever...  
  #sleep 3
end

########## cofiguration ###########
#config["config"].each { |key, value| instance_variable_set("@#{key}", value) }
begin
  $config = YAML.load_file(File.dirname(__FILE__) + "/config.yml")
rescue
  puts "\n---------------------------------- ERROR ------------------------------------------------------".underline.bright.background(:red)
  puts "\nError: Couldn't find configuration file 'features/support/config.yml'".underline.bright.background(:magenta)
  puts "Create a new file called 'config.yml' based on 'config.yml.EXAMPLE' - don't rename it!"
  puts "\nNEVER CHECK IN THE 'config.yml'!"
  puts "-----------------------------------------------------------------------------------------------\n\n"
  exit; 0
end



if(ENV['TEST_ENV'].nil? || ENV['TEST_ENV'] == "")
  puts "\n@@@ your environment variable 'TEST_ENV' hasn't been set up. So i will set it to 'tst' ok, IF YOU DON'T MIND of course... \n".underline
  ENV['TEST_ENV'] = "tst"
else
  puts "--> Using ".underline + "#{ENV['TEST_ENV']}".underline.bright.background(:red) + " Configuration ".underline + " and base_url is: #{$config[ENV['TEST_ENV']]['base_url']}\n\n"
end  

def get_prop key  
  #puts ENV['TEST_ENV']  
  $config[ENV['TEST_ENV']][key]  
end

def get_omniture_log_destination
  omn_log_dir = get_prop "omniture_log_file_dir" 
  omn_log_dir = "#{File.dirname(__FILE__)}/../.." if omn_log_dir == nil   
  return "#{omn_log_dir}/omniture_logs.txt" 
end  


system "export CUCUMBER_COLORS=passed=white,bold:passed_param=white,bold,underline"

# just to clean up the log file before...
#if !ENV["APPEND_OMNITURE"]
File.open(get_omniture_log_destination, 'w') { |f| }

########## END cofiguration ###########


### GLOBAL VARIABLES ####
$XML_SIZE_ERROR = " - INCORRECT NUMBER OF XML's returned"
### END GLOBAL VARIABLES ####


#require 'ruby-debug'; debugger; 0;

# clean up old screenshots
#system("rm -rf #{@tomcat_ci}/temp")
system "rm -rf #{File.dirname(__FILE__)}/../../reports/screenshots/*.jpeg"





