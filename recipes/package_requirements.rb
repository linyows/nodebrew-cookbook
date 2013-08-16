# Cookbook Name:: nodebrew
# Recipe:: package requirements

case node[:platform]
when 'ubuntu', 'debian'
  include_recipe 'apt'
end

include_recipe 'build-essential'
include_recipe 'git'

case node[:platform]
when 'redhat', 'centos', 'amazon', 'oracle'
  package 'openssl-devel'
when 'ubuntu', 'debian'
  package 'libssl-dev'
end
