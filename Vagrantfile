# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'Ubuntu_12.04-Chef_11.4.4'
  config.vm.box_url = 'http://goo.gl/np92o'
  config.vm.hostname = 'nodebrew'
  config.vm.network :private_network, ip: '192.168.33.33'

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(cookbooks site-cookbooks)
    chef.add_recipe 'nodebrew'
    chef.json = {
      :nodebrew => {
        :nodes => [
          { :version => 'v0.11.5', :binary => true },
          { :version => 'v0.10.15', :binary => true }
        ],
        :use => 'v0.10.15',
        :npm => {
          'v0.11.5' => [
            'underscore',
            'coffee-script'
          ],
          'v0.10.15' => [
            'async@0.2.9',
            { :name => 'bower', :version => '1.1.2', :action => 'install' }
          ]
        }
      }
    }
  end
end
