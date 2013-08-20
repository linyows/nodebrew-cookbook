#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake-foodcritic'
require 'rake-chef-syntax'

namespace :chef do
  task :spec => [:foodcritic, :syntax_check]
end
