# Cookbook Name:: nodebrew
# Provider:: script

include Chef::Mixin::Nodebrew

def whyrun_supported?
  true
end

action :run do
  converge_by "Run #{new_resource}" do
    script new_resource.name do
      action :nothing
      interpreter 'bash'
      code add_nodebrew_path(new_resource.code)
      creates new_resource.creates if new_resource.creates
      cwd new_resource.cwd if new_resource.cwd
      environment new_resource.environment if new_resource.environment
      flags new_resource.flags if new_resource.flags
      group new_resource.group if new_resource.group
      interpreter new_resource.interpreter if new_resource.interpreter
      path new_resource.path if new_resource.path
      returns new_resource.returns if new_resource.returns
      timeout new_resource.timeout if new_resource.timeout
      user new_resource.user if new_resource.user
      umask new_resource.umask if new_resource.umask
    end.run_action(:run)

    new_resource.updated_by_last_action(true)
  end
end
