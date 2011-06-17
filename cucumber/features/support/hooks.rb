

After do |step|  
  if step.failed?    
    name = "#{step.line}_#{Time.new.to_i}"
    #name = Time.new.to_i
    File.open("./reports/screenshots/#{name}.jpeg", 'wb') do |f|
      f.write(Base64.decode64(page.driver.browser.screenshot_as(:base64)))
    end    
    puts "about to raise ERROR...."
    raise "lessthanimg src='screenshots/#{name}.jpeg' /greaterthan"
  end
end