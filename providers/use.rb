# Cookbook Name:: nodebrew
# Provider:: use

include Chef::Mixin::Nodebrew

def whyrun_supported?
  true
end

action :run do
  converge_by "Run #{new_resource}" do
    nodebrew_script new_resource.name do
      action :nothing
      code "nodebrew use #{new_resource.node_version}"
      user new_resource.user
      group (new_resource.group || new_resource.user)
    end.run_action(:run)

    Chef::Log.info "Using #{new_resource}"

    new_resource.updated_by_last_action(true)
  end
end
