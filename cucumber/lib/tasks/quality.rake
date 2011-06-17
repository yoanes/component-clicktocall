
namespace :quality do  
  desc "Looks for unused steps, build will FAIL case there is at least one."  
  task :unused_steps do  
    system "bundle exec cucumber -d -f UnusedSteps"
    #puts "#{$?}"    
  end
end

