# Leonardo Correa
# all the unused steps in your project, run the following command:
#
# bundle exec cucumber -d -f UnusedSteps
#
# -d for --dry-run and -f for --format
#

require 'cucumber/formatter/stepdefs'
require 'rainbow'

class UnusedSteps < Cucumber::Formatter::Stepdefs
  def print_summary(features)
    add_unused_stepdefs
    keys = @stepdef_to_match.keys.sort {|a,b| a.regexp_source <=> b.regexp_source}
        
    #puts "---> Total number of steps analized: #{keys.size}\n"  
    puts "---> The following steps are NOT being used:\n"        
    1..165.times{print "="} 
    puts "\n"    
    puts "| Step ".ljust(92) + "| Filename ".ljust(72) + "|"
    1..165.times{print "="} 
    puts "\n"    
    
    tot_unused = 0
    keys.each do |stepdef_key|
      if @stepdef_to_match[stepdef_key].none?        
        tot_unused = tot_unused + 1        
        puts "|#{stepdef_key.regexp_source.ljust(90)} | #{stepdef_key.file_colon_line.ljust(70)}|"      
      end      
    end
    1..165.times{print "="}     
    puts "\n"
    puts "---> Total steps NOT being used: #{tot_unused} out of #{keys.size}\n\n"
            
    print_stats(features, nil)  
    
    #raise RuntimeError, "hey, you have #{tot_unused} unused steps! Please take care of your test suite!" if tot_unused != 0
    if tot_unused != 0
      puts "\n\nERROR: hey, you have #{tot_unused} unused steps! Please take care of your test suite!\n\n".color(:cyan).background(:red).bright
      exit 1; 
    end
    
  end
end