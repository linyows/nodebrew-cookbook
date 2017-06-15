# Cookbook Name:: nodebrew
# Resource:: node

actions :install, :uninstall
default_action :install

def initialize(*args)
  super
  @action = :install
end

attribute :version,
  :kind_of => String,
  :name_attribute => true,
  :regex => /^(v?[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}|latest|stable)$/,
  :required => true
attribute :binary,
  :kind_of => [TrueClass, FalseClass],
  :default => false
attribute :user,
  :kind_of => String,
  :default => 'root'
attribute :group,
  :kind_of => String
