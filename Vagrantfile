# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20211026.0.0"
  config.vm.provider :virtualbox do |vb|
        vb.name = "ubuntu-server-20-lts"
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//var//www//", "1"]
    end
	
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

config.vm.hostname  = "ubuntu-server"
config.vm.network "private_network", ip: "192.168.33.12"
config.vm.network "forwarded_port", guest: 3306, host: 3306
config.vm.synced_folder "./code","/var/www/", type: "virtualbox",
  id: "vagrant-root",
  owner: "vagrant",
  group: "www-data",
  mount_options: ["dmode=775,fmode=777"]
 
# Optional NFS. Make sure to remove other synced_folder line too
# config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

   config.vm.provision "shell" , run: "once" do |s|
    	s.path = "provision/setup.sh"
	  end

end



  
