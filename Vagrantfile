# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "db12102" , primary: true do |db12102|
    db12102.vm.box = "centos-6.5-x86_64"
    db12102.vm.box_url = "https://dl.dropboxusercontent.com/s/np39xdpw05wfmv4/centos-6.5-x86_64.box"

    db12102.vm.hostname = "db12c.example.com"
    db12102.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    db12102.vm.synced_folder "C:\\Users\\lucas_j\\Downloads", "/software"

    db12102.vm.network :private_network, ip: "10.10.10.9"
  
    db12102.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm"     , :id, "--memory", "2548"]
      vb.gui = true
      vb.customize ["modifyvm"     , :id, "--name"  , "db12102"]
      vb.customize ["modifyvm"     , :id, "--cpus"  , 2]
    end

  
    db12102.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml;rm -rf /etc/puppet/modules;ln -sf /vagrant/puppet/modules /etc/puppet/modules"
    
    db12102.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "db.pp"
      puppet.options           = "--verbose --hiera_config /vagrant/puppet/hiera.yaml"
  
      puppet.facter = {
        "environment" => "development",
        "vm_type"     => "vagrant",
      }
      
    end
  
  end

end
