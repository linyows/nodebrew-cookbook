# encoding: utf-8
# Cookbook Name:: nodebrew
# Provider:: npm

def load_current_resource
  super
  @regex_for_grep = '^[├└]─[─┬]'
  @pkg = new_resource.package
  @pkg << "@#{new_resource.version}" if new_resource.version
  @path = new_resource.path
  @json = new_resource.package_json
  @node_ver = new_resource.node_version
end

action :install do
  nodebrew_use "use #{@node_ver} for #{@pkg} installation" do
    node_version new_resource.node_version
  end if @node_ver

  case
  when @pkg && @json && @path
    execute "install #{new_resource.name} from package.json_at #{@path} by npm" do
      cwd @path
      command 'npm install'
    end

  when @pkg && @path
    execute "install #{new_resource.name} into #{@path} by npm" do
      cwd @path
      command "npm install #{@pkg}"
      not_if "cd #{@path} && npm ls 2> /dev/null | grep '#{@regex_for_grep} #{@pkg}'"
    end

  when @pkg
    execute "install #{new_resource.name} by npm" do
      command "npm -g install #{@pkg}"
      not_if "npm -g ls 2> /dev/null | grep '#{@regex_for_grep} #{@pkg}'"
    end

  else
    Chef::Log.warn 'Npm attributes is missing. Action will be skipped.'
  end
end

action :uninstall do
  nodebrew_use "use #{@node_ver} for #{@pkg} uninstallation" do
    node_version new_resource.node_version
  end if @node_ver

  case
  when @pkg && @path
    execute "uninstall #{new_resource.name} from #{@path} by npm" do
      cwd @path
      command "npm uninstall #{@pkg}"
      only_if "cd #{@path} && npm ls 2> /dev/null | grep '#{@regex_for_grep} #{@pkg}'"
    end

  when @pkg
    execute "uninstall #{new_resource.name} by npm" do
      command "npm -g uninstall #{@pkg}"
      only_if "npm -g ls 2> /dev/null | grep '#{@regex_for_grep} #{@pkg}'"
    end

  else
    Chef::Log.warn 'Npm attributes is missing. Action will be skipped.'
  end
end
