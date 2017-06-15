# Cookbook Name:: nodebrew
# Recipe:: default

include_recipe 'nodebrew::package_requirements'

nodebrew node['nodebrew']['root'] do
  action :install
  repository node['nodebrew']['repository']
  ref node['nodebrew']['ref']
  upgrade node['nodebrew']['upgrade']
  user node['nodebrew']['user']
  group node['nodebrew']['group'] if node['nodebrew']['group']
end

Array(node['nodebrew']['nodes']).each do |node|
  nodebrew_node node['version'] do
    binary node['binary']
  end
end

Array(node['nodebrew']['npm']).each do |node_ver, npms|
  Array(npms).each do |npm|
    if npm.is_a?(Hash)
      nodebrew_npm "#{npm['name']} on node@#{node_ver}" do
        package npm['name']
        node_version node_ver
        %w(version action).each do |attr|
          send(attr, npm[attr]) if npm[attr]
        end
      end
    else
      nodebrew_npm "#{npm} on node@#{node_ver}" do
        package npm
        node_version node_ver
      end
    end
  end
end

nodebrew_use "use #{node['nodebrew']['use']}" do
  node_version node['nodebrew']['use']
end if node['nodebrew']['use']
