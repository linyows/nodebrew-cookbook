# Cookbook Name:: nodebrew
# Resource:: use

actions :run
default_action :run

attribute :name,
  :kind_of => String,
  :name_attribute => true
attribute :node_version,
  :kind_of => String,
  :required => true
attribute :user,
  :kind_of => String
attribute :group,
  :kind_of => String
