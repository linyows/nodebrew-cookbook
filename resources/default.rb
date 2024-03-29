# Cookbook Name:: nodebrew
# Resource:: nodebrew

actions :install
default_action :install

attribute :repository,
  :kind_of => String,
  :default => 'https://github.com/hokaccha/nodebrew.git'
attribute :ref,
  :kind_of => String,
  :default => 'master'
attribute :root,
  :kind_of => String,
  :default => '$HOME/.nodebrew'
attribute :user,
  :kind_of => String,
  :default => 'root'
attribute :group,
  :kind_of => String
attribute :upgrade,
  :kind_of => [TrueClass, FalseClass],
  :default => false
attribute :cookbook,
  :kind_of => String,
  :default => 'nodebrew'
