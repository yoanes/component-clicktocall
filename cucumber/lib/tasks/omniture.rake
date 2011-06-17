# Cucumber omniture tasks
# those tests will be rewritten for local Wireless Event Capture - stop using TEST env.

namespace :cucumber do
  namespace :omniture do
    desc "Runs all click to call features separeted each other (workaround)"  
    task :click_to_call do
      
      errors = []
      
      system "bundle exec cucumber features/omniture/click_to_call/click_to_call_in_list.feature DEVICE=@iPhone-OS-4.0"        
      if($? != 0)
        errors << "click_to_call_in_list.feature"
      end
          
      system "bundle exec cucumber features/omniture/click_to_call/click_to_call_in_bpp.feature DEVICE=@iPhone-OS-4.0"
      if($? != 0)
        errors << "click_to_call_in_bpp.feature"
      end    
      
      #printing errors 
      if(errors.size != 0)
        puts "\n\n-----------------> There have been errors in the following features:"
        errors.each{|e| puts "   #{e}"}
      end      
      #puts "\n\n-----------------> FINAL RESULT: #{$?}"
    end     
    
    #desc "It runs all Omniture tests and appends xml's at the end of the file but it cleans before starting."  
    #task :all_omniture do
      #require "#{File.dirname(__FILE__)}/features/support/env_helper.rb"    
      #File.open(get_omniture_log_destination, 'w') { |f| }        
    #end
    
  end
end