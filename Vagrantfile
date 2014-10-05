# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.define :centos do |centos|
    centos.vm.box = 'CentOS_6.4-Chef_11.4.4'
    centos.vm.box_url = 'http://goo.gl/GZqvsF'
    centos.vm.hostname = 'centos'
  end

  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.box = 'Ubuntu_12.04-Chef_11.4.4'
    ubuntu.vm.box_url = 'http://goo.gl/np92o'
    ubuntu.vm.hostname = 'ubuntu'
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(../ vendor/cookbooks)
    chef.add_recipe 'nodebrew'
    chef.json = {
      :nodebrew => {
        :nodes => [
          { :version => 'latest', :binary => true },
        ],
        :use => 'latest',
        :npm => {
          'latest' => [
            'underscore@latest',
            'coffee-script',
            {
              :name => 'bower',
              :action => 'install'
            }
          ]
        }
      }
    }
  end
end
