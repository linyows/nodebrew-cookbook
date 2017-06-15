# Cookbook Name:: nodebrew
# Attributes:: default

default['nodebrew']['repository'] = 'git://github.com/hokaccha/nodebrew.git'
default['nodebrew']['ref']        = 'master'
default['nodebrew']['upgrade']    = true
default['nodebrew']['root']       = '/usr/local/lib/nodebrew'
default['nodebrew']['user']       = 'root'
default['nodebrew']['group']      = nil
default['nodebrew']['nodes']      = []
default['nodebrew']['npm']        = {}
