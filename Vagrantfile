Vagrant.configure('2') do |config|
  config.pe_build.version = '3.0.1'
#  config.pe_build.download_root = 'http://s3.amazonaws.com/pe-builds/released/3.0.1'
  config.pe_build.download_root = "file://#{Dir.pwd}/.cache"

  config.vm.box = 'ubuntu-12.04-amd64-server'
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'

  config.vm.define 'master' do |m|
    m.vm.hostname = 'master.r10k.puppetlabs.vm'
    m.vm.network :private_network, :auto_network => true

    m.vm.provision :hosts do |hosts|
      hosts.autoconfigure = true
    end

    m.vm.network :forwarded_port, guest: 443, host: 8443
    
    m.vm.provider 'virtualbox' do |vbox|
      vbox.customize ['modifyvm', :id, '--memory', '4096']
    end

    m.vm.provision :pe_bootstrap do |bstrap|
      bstrap.role = :master
      bstrap.verbose = true
    end
  end

  config.vm.define 'agent0' do |a|
    a.vm.hostname = 'agent0.r10k.puppetlabs.vm'
    a.vm.network :private_network, :auto_network => true

    a.vm.provision :hosts do |hosts|
      hosts.autoconfigure = true
    end

    a.vm.provision :pe_bootstrap
  end
end  
