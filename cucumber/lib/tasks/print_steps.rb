step_definition_dir = "./features/step_definitions"

f = File.new("all_steps.htm", "w")
given_array = []
when_array = []
then_array = []

title = "Existing Cucumber Steps"
f << 
"<html>
  <title>WhereisMobile - #{title}</title>
  <body>
    <style>
      #tbl_content{
        border: 1px solid #D0D0D0 ;        
        border-collapse: collapse;        
      }
      th { 
        border: 1px solid gray; 
        background-color: #D0D0D0;
      }
      
      td { 
        border: 1px solid #D0D0D0;	
        padding: 5px; 
      }        
      
      .separator td{
        background-color: #D0D0D0;        
        height: 10px;
      }
    </style>
      
    <img src='http://tst.mobile.whereis.com.au/imageserver/wm/images/header/wmlogo_HD800_138x67.gif' alt=''/> 
    <div id='divTitle'>
      <h2> 
      
        #{title} 
      </h2>
    </div>  
    
    <hr/>    
"
f << "<br/><table id='tbl_content'><th>Cond</th><th>Regex</th><th>Modifiers</th><th>Step Definition Args</th><th>Source file</th>"

Dir.glob(File.join(step_definition_dir,'**/*.rb')).each do |step_file|  
  File.new(step_file).read.each_line do |line|
    next unless line =~ /^\s*(?:Given|When|Then)\s+\//
    matches = /(Given|When|Then)\s*\/(.*)\/([imxo]*)\s*do\s*(?:$|\|(.*)\|)/.match(line).captures
    matches << step_file
    req = matches[1].gsub(/\(\[\^"\]\*\)/ , "<b>VAR</b>")
    req.gsub! "\\.", "."
    req.gsub! "\^", ""
    req.gsub! "\$", ""
    step = { :regex => req,
      :modifier => matches[2],
      :params => matches[3],
      :file => matches[4]
      }
    if (matches[0] == "Given")
      given_array << step
    end
    if (matches[0] == "Then")
      then_array << step
    end
    if (matches[0] == "When")
      when_array << step
    end
  end
end


given_array.each do |item|

    f << "<tr>"
     f << "<td><b>Given</b></td>"
     f << "<td>#{item[:regex]}</td>"
    f << "<td>#{item[:modifier]}</td>"
    f << "<td>#{item[:params]}</td>"
    f << "<td><a href=\"#{item[:file]}\">#{item[:file]}</a></td>"
    f << "</tr>"
end
f << "<tr class='separator'><td colspan='5'></td><tr>"

when_array.each do |item|

    f << "<tr>"
     f << "<td><b>When<b></td>"
     f << "<td>#{item[:regex]}</td>"
    f << "<td>#{item[:modifier]}</td>"
    f << "<td>#{item[:params]}</td>"
    f << "<td><a href=\"#{item[:file]}\">#{item[:file]}</a></td>"
    f << "</tr>"
end

f << "<tr class='separator'><td colspan='5'></td><tr>"

then_array.each do |item|

    f << "<tr>"
     f << "<td><b>Then<b></td>"
     f << "<td>#{item[:regex]}</td>"
    f << "<td>#{item[:modifier]}</td>"
    f << "<td>#{item[:params]}</td>"
    f << "<td><a href=\"#{item[:file]}\">#{item[:file]}</a></td>"
    f << "</tr>"
end

f << "</table>"

total_steps = given_array.size + when_array.size + then_array.size

f << "
<br/>
Total Steps: #{total_steps}

</body>
</html>"