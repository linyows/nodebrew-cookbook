include Chef::Mixin::Nodebrew

def whyrun_supported?
  true
end

use_inline_resources

action :run do
  converge_by "Run #{new_resource}" do
    nodebrew_script new_resource.name do
      action :nothing
      code "nodebrew use #{new_resource.node_version}"
      user new_resource.user
      group (new_resource.group || new_resource.user)
    end.run_action(:run)

    Chef::Log.info "Using #{new_resource}"
  end
end
