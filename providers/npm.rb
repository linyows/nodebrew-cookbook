# Cookbook Name:: nodebrew
# Provider:: npm

include Chef::Mixin::Nodebrew

def whyrun_supported?
  true
end

action :install do
  pkg = new_resource.package
  pkg << "@#{new_resource.version}" if new_resource.version
  path = new_resource.path
  json = new_resource.package_json
  node_ver = new_resource.node_version

  converge_by "Install #{new_resource}" do
    nodebrew_script "use #{node_ver} for #{pkg} installation" do
      action :nothing
      environment 'HOME' => ::Dir.home(new_resource.user)
      code "nodebrew use #{new_resource.node_version}"
      user new_resource.user
      group (new_resource.group || new_resource.user)
    end.run_action(:run) if node_ver

    case
    when !pkg
      Chef::Log.error 'Npm attributes is missing. Action will be skipped.'
      raise "Can't run nodebrew_npm installation"

    when package_installed?(pkg, path)
      message_when_the_installed(new_resource)

    when json && path
      nodebrew_script "install #{pkg} from package.json_at #{path} by npm" do
        action :nothing
        environment 'HOME' => ::Dir.home(new_resource.user)
        cwd path
        code 'npm install'
        user new_resource.user
        group (new_resource.group || new_resource.user)
      end.run_action(:run)

    when path
      nodebrew_script "install #{pkg} into #{path} by npm" do
        action :nothing
        environment 'HOME' => ::Dir.home(new_resource.user)
        cwd path
        code "npm install #{pkg}"
      end.run_action(:run)

    else
      nodebrew_script "install #{pkg} by npm" do
        action :nothing
        environment 'HOME' => ::Dir.home(new_resource.user)
        code "npm -g install #{pkg}"
        user new_resource.user
        group (new_resource.group || new_resource.user)
      end.run_action(:run)
    end

    new_resource.updated_by_last_action(true)
  end
end

action :uninstall do
  pkg = new_resource.package
  path = new_resource.path
  node_ver = new_resource.node_version

  converge_by "Uninstall #{new_resource}" do
    nodebrew_script "use #{node_ver} for #{pkg} uninstallation" do
      action :nothing
      environment 'HOME' => ::Dir.home(new_resource.user)
      code "nodebrew use #{new_resource.node_version}"
      user new_resource.user
      group (new_resource.group || new_resource.user)
    end.run_action(:run) if node_ver

    case
    when !pkg
      Chef::Log.error 'Npm attributes is missing. Action will be skipped.'
      raise "Can't run nodebrew_npm uninstallation"

    when !package_installed?(pkg, path)
      message_when_the_not_installed(new_resource)

    when path
      nodebrew_script "uninstall #{pkg} from #{path} by npm" do
        action :nothing
        environment 'HOME' => ::Dir.home(new_resource.user)
        cwd path
        code "npm uninstall #{pkg}"
        user new_resource.user
        group (new_resource.group || new_resource.user)
      end.run_action(:run)

    else
      nodebrew_script "uninstall #{pkg} by npm" do
        action :nothing
        environment 'HOME' => ::Dir.home(new_resource.user)
        code "npm -g uninstall #{pkg}"
        user new_resource.user
        group (new_resource.group || new_resource.user)
      end.run_action(:run)
    end

    new_resource.updated_by_last_action(true)
  end
end
