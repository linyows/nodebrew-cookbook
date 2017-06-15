# Cookbook Name:: nodebrew
# Provider:: node

include Chef::Mixin::Nodebrew

def whyrun_supported?
  true
end

action :install do
  converge_by "Install #{new_resource}" do
    case
    when node_installed?(new_resource.version)
      message_when_the_installed(new_resource)

    else
      Chef::Log.info "Building #{new_resource}, this could take a while..."
      install_start = Time.now

      install = 'install'
      install << '-binary' if new_resource.binary
      command = "nodebrew #{install} #{new_resource.version}"

      nodebrew_script command do
        action :nothing
        code command
        user new_resource.user
        group (new_resource.group || new_resource.user)
      end.run_action(:run)

      install_time = (Time.now - install_start) / 60.0
      Chef::Log.info "#{new_resource} build time was #{install_time} minutes"

      new_resource.updated_by_last_action(true)
    end
  end
end

action :uninstall do
  converge_by "Uninstall #{new_resource}" do
    case
    when !node_installed?(new_resource.version)
      message_when_the_not_installed(new_resource)

    else
      command = "nodebrew uninstall #{new_resource.version}"

      nodebrew_script command do
        action :nothing
        code command
        user new_resource.user
        group (new_resource.group || new_resource.user)
      end.run_action(:run)

      Chef::Log.info "#{new_resource} was successfully uninstall"

      new_resource.updated_by_last_action(true)
    end
  end
end
