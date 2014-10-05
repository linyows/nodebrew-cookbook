# Cookbook Name:: nodebrew
# Recipe:: package requirements

include_recipe 'build-essential'
include_recipe 'git'

case node['platform']
when 'redhat', 'centos', 'amazon', 'oracle'
  package 'openssl-devel'
when 'ubuntu', 'debian'
  package 'libssl-dev'
end
