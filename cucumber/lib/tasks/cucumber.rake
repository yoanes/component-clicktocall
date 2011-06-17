

namespace :cucumber do
  
  desc "Runs all generic (firefox) features with cookies enabled."
  task :generics do
    system "bundle exec cucumber features/generic/ --tags @firefox --tags ~@wip"
  end  

  desc "Runs all generic (firefox) features with cookies DISABLED."
  task :generics_cookies_disabled do    
    system "bundle exec cucumber features/generic/directions.feature:18 --tags @firefox --tags ~@wip DISABLE_COOKIES=true"
  end
    
end






