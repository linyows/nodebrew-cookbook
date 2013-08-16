# Cookbook Name:: nodebrew
# Provider:: script

include Chef::Mixin::Nodebrew

action :run do
  command = <<-CMD.strip.gsub(/^ {4}/, '')
    export NODEBREW_ROOT="#{nodebrew_root}"
    export PATH="${NODEBREW_ROOT}/current/bin:$PATH"
    #{new_resource.code}
  CMD

  script new_resource.name do
    action :nothing
    interpreter 'bash'
    code command
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
