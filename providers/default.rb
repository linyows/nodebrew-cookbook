# Cookbook Name:: nodebrew
# Provider:: default

def whyrun_supported?
  true
end

action :install do
  cache_path = Chef::Config['file_cache_path']
  src_path = "#{cache_path}/nodebrew"

  converge_by "Install #{new_resource}" do
    directory ::File.dirname(src_path) do
      owner new_resource.user
    end

    git src_path do
      repository new_resource.repository
      reference new_resource.ref
      if new_resource.upgrade
        action :checkout
      else
        action :sync
      end
      user new_resource.user
      group (new_resource.group || new_resource.user)
    end

    execute "setup_nodebrew_#{new_resource.name}" do
      cwd src_path
      command 'perl nodebrew setup'
      environment 'NODEBREW_ROOT' => new_resource.root
      user new_resource.user
      group (new_resource.group || new_resource.user)
      not_if { ::File.exists?(new_resource.root) && !new_resource.upgrade }
    end

    ruby_block 'initialize_nodebrew' do
      block do
        ENV['NODEBREW_ROOT'] = new_resource.root
        ENV['PATH'] = "#{ENV['NODEBREW_ROOT']}/current/bin:#{ENV['PATH']}"
      end
      action :nothing
    end

    if new_resource.user == 'root'
      r = template '/etc/profile.d/nodebrew.sh' do
        source 'nodebrew.sh.erb'
        mode '0644'
        variables(
          :nodebrew_root => new_resource.root
        )
        cookbook new_resource.cookbook
        notifies :create, 'ruby_block[initialize_nodebrew]', :immediately
      end
      new_resource.updated_by_last_action(r.updated_by_last_action?)
    else
      r = execute 'PATH for nodebrew' do
        command "echo \"export PATH=~/.nodebrew/current/bin:\\$PATH\" >> $(echo ~#{new_resource.user})/.bashrc"
        user new_resource.user
        group (new_resource.group || new_resource.user)
        not_if "cat $(echo ~#{new_resource.user})/.bashrc | grep -q nodebrew"
      end
      new_resource.updated_by_last_action(r.updated_by_last_action?)
    end
  end
end
