# Cookbook Name:: nodebrew
# Recipe:: package requirements

build_essential 'for node'
include_recipe 'git'

case node['platform']
when 'redhat', 'centos', 'amazon', 'oracle'
  package 'openssl-devel'
when 'ubuntu', 'debian'
  package 'libssl-dev'
end
