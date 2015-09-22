VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "ubuntu/trusty64"

	config.vm.provider "virtualbox" do |v|
	  v.memory = 1300
	  v.cpus = 4
  	  v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
	end

	config.vm.network "forwarded_port", guest: 3306, host: 33066, protocol: 'tcp'
	config.vm.network "forwarded_port", guest: 3306, host: 33066, protocol: 'udp'
	config.vm.network "forwarded_port", guest: 80, host: 80, protocol: 'tcp'	
	config.vm.network "forwarded_port", guest: 80, host: 80, protocol: 'udp'	

	config.vm.synced_folder "webroot/", "/var/www", create: true, type: "nfs"

	config.vm.network :private_network, ip: "192.168.56.101"

	config.vm.provision "shell", path: "install_vagrant.sh", privileged: false
	config.vm.provision "shell", path: "bootstrap_vagrant.sh", run: "always", privileged: false
end