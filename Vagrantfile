Vagrant.configure('2') do |config|
  config.vm.box = 'base'

  config.vm.provision :puppet do |p|
    p.manifests_path = 'puppet/manifests'
    p.module_path = 'puppet/modules'
    p.manifest_file = 'site.pp'
    p.options = '--verbose'
  end
end  
