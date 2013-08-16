# Cookbook Name:: nodebrew
# Provider:: default

action :install do
  cache_path = Chef::Config['file_cache_path']
  src_path = "#{cache_path}/nodebrew"

  directory ::File.dirname(src_path) do
    recursive true
  end

  git src_path do
    repository new_resource.repository
    reference new_resource.ref
    if new_resource.upgrade
      action :checkout
    else
      action :sync
    end
  end

  execute 'setup_nodebrew' do
    cwd src_path
    command 'perl nodebrew setup'
    environment 'NODEBREW_ROOT' => new_resource.root
    user new_resource.user
    not_if { ::File.exists?(new_resource.root) && !new_resource.upgrade }
  end

  ruby_block 'initialize_nodebrew' do
    block do
      ENV['NODEBREW_ROOT'] = new_resource.root
      ENV['PATH'] = "#{ENV['NODEBREW_ROOT']}/current/bin:#{ENV['PATH']}"
    end
    action :nothing
  end

  r = template '/etc/profile.d/nodebrew.sh' do
    source 'nodebrew.sh.erb'
    mode '0644'
    variables(
      :nodebrew_root => new_resource.root
    )
    notifies :create, 'ruby_block[initialize_nodebrew]', :immediately
  end
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end
