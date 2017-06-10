# Cookbook Name:: nodebrew
# Resource:: nodebrew

actions :install
default_action :install

def initialize(*args)
  super
  @action = :install
end

attribute :repository,
  :kind_of => String,
  :default => 'git://github.com/hokaccha/nodebrew.git'
attribute :ref,
  :kind_of => String,
  :default => 'master'
attribute :root,
  :kind_of => String,
  :name_attribute => true,
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
