# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Configure Centos 6.5 vm
  config.vm.define "centos65" do |centos65|
    centos65.vm.box = "notgovready-centos-6.5-x86_64-noX-0.1.2"
    centos65.vm.box_url = "https://s3.amazonaws.com/govready-assets/vm/notgovready-centos-6.5-x86_64-noX-0.1.2.box"

    # Fix for tty
    # config.ssh.pty
    
    # network config
    centos65.vm.network :private_network, ip: "192.168.56.102"
    centos65.vm.network :forwarded_port, guest: 80, host: 8082
    centos65.vm.network :forwarded_port, guest: 22, host: 2422, auto_correct: false,  d: "ssh"

    # Sync overall cloudstart directory on host machine with "/vagrant" directory on  uest machine
    #centos65.vm.synced_folder "../../", "/vagrant", group: "vagrant", owner:  vagrant", create: rue

    # Launch virtualbox GUI window
    centos65.vm.provider "virtualbox" do |v|
      v.gui = true
    end
  end
  
  # Configure Ubuntu 12.04.04 vm
  config.vm.define "ubuntu12044" do |ubuntu12044|
    ubuntu12044.vm.box = "ubuntu12044-noX-0.1.1"
    ubuntu12044.vm.box_url = "https://s3.amazonaws.com/govready-assets/vm/ubuntu12044-noX-0.1.1.box"

    # network config
    ubuntu12044.vm.network :private_network, ip: "192.168.56.103"
    ubuntu12044.vm.network :forwarded_port, guest: 80, host: 8083
    ubuntu12044.vm.network :forwarded_port, guest: 22, host: 2322, auto_correct: false, id: "ssh"

    # Sync overall cloudstart directory on host machine with "/vagrant" directory on guest machine
    #ubuntu12044.vm.synced_folder "../../", "/vagrant", group: "vagrant", owner: "vagrant", create: true   

    # Launch virtualbox GUI window
    ubuntu12044.vm.provider "virtualbox" do |v|
      v.gui = true
    end
  end

end

