# Cookbook Name:: nodebrew
# Provider:: use

include Chef::Mixin::Nodebrew

action :run do
  nodebrew_script new_resource.name do
    action :nothing
    code "nodebrew use #{new_resource.node_version}"
  end.run_action(:run)

  Chef::Log.info "Using #{new_resource}"

  new_resource.updated_by_last_action(true)
end
