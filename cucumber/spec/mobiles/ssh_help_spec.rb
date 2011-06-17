
require "#{File.dirname(__FILE__)}/../../features/step_definitions/ominiture_strategies/ssh_helper.rb"

describe "ssh_helper, #leotest" do
  it "get_ssh1 should return the ssh object not null" do  
    ssh = get_ssh1
    ssh.should_not be_nil
    ssh.host.should == "mbapprs01p-v02t.sst.sensis.com.au"              
  end

  it "get_ssh2 should return the ssh object not null" do  
    ssh = get_ssh2
    ssh.should_not be_nil
    ssh.host.should == "mbapprs02p-v02t.sst.sensis.com.au"              
  end
  
  it "get_ssh2 should return the ssh object not null" do  
    ssh = get_ssh3
    ssh.should_not be_nil
    ssh.host.should == "mbapprs03p-v02t.sst.sensis.com.au"              
  end
  
end
