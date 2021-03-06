name             'nodebrew'
maintainer       'linyows'
maintainer_email 'linyows@gmail.com'
license          'MIT'
description      'Installs and manages your versions of node.js in chef with nodebrew'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.7.4'

recipe 'nodebrew', 'Installs and configures nodebrew'

%w(centos redhat fedora ubuntu debian).each { |os| supports os }
%w(build-essential git).each { |cookbook| depends cookbook }

source_url 'https://github.com/linyows/nodebrew-cookbook'
issues_url 'https://github.com/linyows/nodebrew-cookbook/issues'
chef_version '>= 12.9' if respond_to?(:chef_version)
