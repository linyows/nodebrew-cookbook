# Cookbook Name:: nodebrew
# Resources:: npm

actions :install, :uninstall
default_action :install

def initialize(*args)
  super
  @action = :install
end

attribute :name,
  :kind_of => String,
  :name_attribute => true
attribute :package,
  :kind_of => String,
  :name_attribute => true
attribute :version,
  :kind_of => String,
  :default => nil
attribute :node_version,
  :kind_of => String,
  :default => nil
attribute :path,
  :kind_of => String,
  :default => nil
attribute :package_json,
  :kind_of => [TrueClass, FalseClass],
  :default => false
attribute :user,
  :kind_of => String,
  :default => 'root'
attribute :group,
  :kind_of => String
