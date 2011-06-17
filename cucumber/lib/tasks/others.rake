
namespace :others do  
  desc "Generates all_steps.htm file in the cucumber root folder."  
  task :print_all_steps do  
    res = system "ruby lib/tasks/print_steps.rb"    
    if res 
      puts "take a look at the file all_steps.htm in your browser\n"
    else 
      puts "ERROR: Couldn't generate step report.\n"
    end
  end
end