namespace :setup do
  desc "Downloads all dependencies to your gem system path"
  task :bundle do
    puts "---------> getting gems... they will be installed in your system."
    #res = system "bundle install --path vendor"
    res = system "bundle install"
    raise "ERROR: couldn't run bundler" if !res
  end    
end