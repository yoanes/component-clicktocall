require 'timeout'
require 'rainbow'
require "socket"

namespace :tomcat do
    
  @tomcat_ci = "tomcat-ci" #folder will be created and apache-tomcat extracted to it. It should be .gitignored.
  @http_port = "7080"
  @shutdown_port = "7005"
  @ajp_port = "7009"  
  @war_file = "../build/whereismobile-*.war" #this file will be copied from master Jenkins to the slave
  @msg_prefix = "   --> "  
  
  hostname = Socket::gethostname #system("hostname")
   
  if Socket::gethostname == "MOB-SRV"
    @catalina_home_in_CI = "/home/jenkins/jenkins/workspace/whereis-mobile-integration/cucumber/tomcat-ci/apache-tomcat-6.0.32" #CI
  else
    @catalina_home_in_CI = "/home/leonardo/aajava/workspace/whereis-mobile/cucumber/tomcat-ci/apache-tomcat-6.0.32" #local Leo. Maybe pick this up from config.yml...
  end
  
  desc "Starts tomcat in the folder tomcat-ci for Cucumber tests."
  task :start do
    if File.exists? @tomcat_ci               
      loginfo "Cool! I will use tomcat in '#{@tomcat_ci}' folder..."
      
      system("rake tomcat:stop")
    else
      download_extract_tomcat      
      tomcat_port_setup_server_xml      
      tomcat_port_setup_catalina_sh                  
    end  
    ########################## Deploying Application ###########################################
    #loginfo "removing old 'tomcat-ci/apache-tomcat-6.0.32/webapps/whereismobile'..."
    #system("rm -rf tomcat-ci/apache-tomcat-6.0.32/webapps/whereismobile")
    
    #loginfo "unziping #{@war_file} 'tomcat-ci/apache-tomcat-6.0.32/webapps/whereismobile'..."
    #res = system("unzip -o #{@war_file} -d tomcat-ci/apache-tomcat-6.0.32/webapps/whereismobile > /dev/null 2>&1")
    #loginfo "deployed has been done successfullly!!!#{res}"
    
    ### some tomcat clean ups...
    system("rm -rf #{@tomcat_ci}/apache-tomcat-6.0.32/temp")
    system("rm -rf #{@tomcat_ci}/apache-tomcat-6.0.32/logs/*.*")    
    system("rm -rf #{@tomcat_ci}/apache-tomcat-6.0.32/work")
    
    loginfo "runing ant deploy-local with hacked CI CATALINA_HOME..."
    system("ant -f ../build.xml deploy-local -Dproject.platform=desk -Denv.CATALINA_HOME='#{@catalina_home_in_CI}'")

    ########################## Starting Tomcat Server ###########################################
    loginfo "starting tomcat server..."
    system("sh tomcat-ci/apache-tomcat-6.0.32/bin/startup.sh -Xms256m -Xmx512m -XX:PermSize=768m -XX:MaxPermSize=1024m")    
    
    loginfo "server has started!!! If you don't believe: http://localhost:7080 - or tail -f tomcat-ci/apache-tomcat-6.0.32/logs/catalina.out"    

    ########################## Double-checking if tomcat is cool ###########################################
    loginfo "I will check if the application is really alive and responsive..."
    begin
      timeout = 180
      Timeout.timeout(timeout.to_i) do
        wait_secs = 7
        #while system('wget -O - --quiet --no-proxy  http://localhost:7080/whereismobile/legal/initialiseLegal.do > /dev/null') != true
        while system('wget -O - --quiet --no-proxy  http://localhost:7080 > /dev/null') != true          
          loginfo "............I will try again in #{wait_secs} seconds (tomcat start up timeout is #{timeout}).............."
          sleep wait_secs.to_i
        end
      end
      loginfo "APPLICATION IS RESPONDNIG!!! you can kick-off your cucumber tests now!!!!"
    rescue Timeout::Error => e
      raise "#{@msg_prefix} TIMEOUT ERROR: Failed to start tomcat server. See logs tomcat-ci/apache-tomcat-6.0.32/logs/catalina.out"
    end    
        
  end ### end tomcat:start
  

  desc "Stops tomcat in the folder tomcat-ci (bin/shutdown.sh and kill -9)."
  task :stop do
    loginfo "I will try to stop tomcat (bin/shutdown.sh and kill -9)..."
    system("sh tomcat-ci/apache-tomcat-6.0.32/bin/shutdown.sh > /dev/null")     
    sleep 1
    loginfo "I guess I finished... I ran the command but can't guarantee that tomcat has died...\n\n"
    system("kill -9 `ps -ef|grep #{@tomcat_ci}|awk '{print $2}'`")
    sleep 1
    loginfo "But this is the output of the command 'ps -ef | grep tomcat-ci'"  
    system "ps -ef | grep tomcat-ci"
  end
  
######################################################################################################  
################################## Functions #########################################################
  def download_extract_tomcat
      ################################# download and unzip ##############################################       
      loginfo "First time? I will create the folder 'tomcat-ci' and downloading apache-tomcat-6.0.32.zip...\n"         
      system("wget 'http://apache.mirror.aussiehq.net.au/tomcat/tomcat-6/v6.0.32/bin/apache-tomcat-6.0.32.zip' --directory-prefix=#{@tomcat_ci}")      
      system("unzip #{@tomcat_ci}/apache-tomcat-6.0.32.zip -d #{@tomcat_ci} > /dev/null 2>&1")
      system("rm #{@tomcat_ci}/apache-tomcat-6.0.32.zip")  
      loginfo "I just downloaded tomcat-6.0.32 extracted to the folder '#{@tomcat_ci}'."            
      system("chmod 777 tomcat-ci/apache-tomcat-6.0.32/bin/*.sh")
      system("rm #{@tomcat_ci}/apache-tomcat-6.0.32/conf/Catalina/localhost/*.xml > /dev/null 2>&1") #CRF cleanup
  end

  def tomcat_port_setup_server_xml
      ################################# server.xml ############################################## 
      loginfo "changing ports in 'tomcat-ci/apache-tomcat-6.0.32/conf/server.xml' from 8xxx to 7xxx and appBase (CRF stuff)..."
      
      server_content = File.new("tomcat-ci/apache-tomcat-6.0.32/conf/server.xml").read
      server_content.gsub!("<Server port=\"8005\" shutdown=\"SHUTDOWN\">", "<Server port=\"#{@shutdown_port}\" shutdown=\"SHUTDOWN\">")    
      server_content.gsub!("<Connector port=\"8080\" protocol=\"HTTP/1.1\"", "<Connector port=\"#{@http_port}\" protocol=\"HTTP/1.1\"")    
      server_content.gsub!("<Connector port=\"8009\" protocol=\"AJP/1.3\"", "<Connector port=\"#{@ajp_port}\" protocol=\"AJP/1.3\"")
      
      old_appbase = '<Host name="localhost"  appBase="webapps"'
      new_appbase = '<Host name="localhost"  appBase="webapps/whereismobile"'
      server_content.gsub!(old_appbase, new_appbase)
      
      server_content.gsub!('xmlValidation="false" xmlNamespaceAware="false">', 'xmlValidation="false" xmlNamespaceAware="false"> <Context path="/imageserver" docBase="../imageserver" /> <Context path="" docBase="." />')      
      
      
      File.open("tomcat-ci/apache-tomcat-6.0.32/conf/server.xml", "w") do |f|
        f.write(server_content) 
      end          
  end
  
  def tomcat_port_setup_catalina_sh
      ################################# catalina.sh ############################################## 
      loginfo "setting CATALINA_HOME 'catalina.sh'..."
      catalina_content = File.new("tomcat-ci/apache-tomcat-6.0.32/bin/catalina.sh").read
      line_sub = "# OS specific support.  $var _must_ be set to either true or false."
                
      base_cucumber_dir = File.dirname(__FILE__).gsub("/lib/tasks", "")
      
      java_opts = "export JAVA_OPTS=\"-Xms256m -Xmx512m -XX:PermSize=768m -XX:MaxPermSize=1024m -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSClassUnloadingEnabled -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000i\""

      catalina_content.gsub!(line_sub, "export CATALINA_HOME=#{base_cucumber_dir}/tomcat-ci/apache-tomcat-6.0.32\n#{java_opts}\n\n#{line_sub}")
            
      File.open("tomcat-ci/apache-tomcat-6.0.32/bin/catalina.sh", "w") do |f|
        f.write(catalina_content) 
      end                 
      
      system("chmod 777 tomcat-ci/apache-tomcat-6.0.32/bin/*.sh") #again in case new file has't got proper permission'    
  end
  
  def loginfo msg
    puts "#{@msg_prefix}#{msg}".underline.bright    
  end
################################# END Functions ######################################################
######################################################################################################  
  
  
end
