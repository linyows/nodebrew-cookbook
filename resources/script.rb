# Cookbook Name:: nodebrew
# Resource:: script

actions :run
default_action :run

def initialize(*args)
  super
  @action = :run
end

attribute :name,
  :kind_of => String,
  :name_attribute => true
attribute :code,
  :kind_of => String,
  :required => true
attribute :creates,
  :kind_of => String
attribute :cwd,
  :kind_of => String
attribute :environment,
  :kind_of => Hash
attribute :flags,
  :kind_of => String
attribute :group,
  :kind_of => String
attribute :interpreter,
  :kind_of => String
attribute :path,
  :kind_of => Array
attribute :returns,
  :kind_of => Array,
  :default => [0]
attribute :timeout,
  :kind_of => Integer
attribute :user,
  :kind_of => String
attribute :umask,
  :kind_of => String

attribute :nodebrew_root,
  :kind_of => String
