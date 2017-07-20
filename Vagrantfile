# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.define "ubuntu-1604", primary: true, autostart: true do |server|
    server.vm.box = "ubuntu/xenial64"
    server.vm.hostname = 'ubuntu1604.example.com'
    server.vm.provision :shell, :privileged => false, :path => "tests/provision_basic_ubuntu.sh"
  end
  
end