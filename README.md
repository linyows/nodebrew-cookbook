Nodebrew Cookbook
=================

[![Build Status](https://secure.travis-ci.org/linyows/nodebrew-cookbook.svg?branch=master)][travis]

Installs and manages your versions of node.js in chef with [nodebrew][nodebrew]

Usage
-----

Role based example:

```ruby
run_list(
  'recipe[nodebrew]'
)

override_attributes(
  :nodebrew => {
    :nodes => [
      { :version => '0.11.5' },
      { :version => '0.10.15', :binary => true }
    ],
    :use => '0.10.15',
    :npm => {
      '0.11.5' => [
        'underscore',
        'coffee-script'
      ],
      '0.10.15' => [
        'underscore',
        'async@0.2.9',
        { :name => 'bower', :version => '1.1.2', :action => 'install' }
      ]
    }
  }
)
```

Requirements
------------

- Chef >= 11.4
- Platform: ubuntu, debian, fedora, centos and redhat
- Cookbook: build-essential and git

Installation
------------

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks. To install Librarian-Chef:

```ruby
cd chef-repo
gem install librarian
librarian-chef init
```

To reference the Git version:

```log
repo="linyows/nodebrew-cookbook"
latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
| ruby -rjson -e '
  j = JSON.parse(STDIN.read);
  puts j.map { |t| t["ref"].split("/").last }.sort.last
')
cat >> Cheffile <<END_OF_CHEFFILE
cookbook 'nodebrew', :git => 'git://github.com/$repo.git', :ref => '$latest_release'
END_OF_CHEFFILE
librarian-chef install
```

why-run support.

Attributes
----------

### nodebrew::default

Key        | Description             | Default
---        | -----------             | -------
repository | nodebrew git repository | git://github.com/hokaccha/nodebrew.git
ref        | git ref                 | master
upgrade    | sync                    | true
root       | nodebrew root           | /usr/local/lib/nodebrew
user       | nodebrew user           | root

Resources / Providers
---------------------

- nodebrew
- nodebrew_node
- nodebrew_npm
- nodebrew_use
- nodebrew_script

### nodebrew

#### Actions

Action  | Description                       | Default
------  | -----------                       | -------
install | install nodebrew to nodebrew_root | yes

#### Attributes

Attribute  | Description             | Default
---------  | -----------             | -------
repository | nodebrew git repository | git://github.com/hokaccha/nodebrew.git
ref        | git ref                 | master
upgrade    | sync                    | true
root       | nodebrew root           | $HOME/.nodebrew
user       | nodebrew user           | root

#### Examples

Install nodebrew to custom path

```ruby
nodebrew '/usr/local/lib/nodebrew'
```

Install nodebrew for a user

```ruby
nodebrew '/usr/local/lib/nodebrew' do
  ref 'v0.6.3'
  user 'vagrant'
end
```

### nodebrew_node

#### Actions

Action  | Description     | Default
------  | -----------     | -------
install | install node.js | yes
uninstall | uninstall node.js | no

#### Attributes

Attribute | Description       | Default
--------- | -----------       | -------
version   | node.js version   |
binary    | install by binary | false

#### Examples

Install node.js

```ruby
nodebrew_node '0.11.5'
```

Install node.js by binary

```ruby
nodebrew_node '0.11.5' do
  binary true
end
```

### nodebrew_npm

#### Actions

Action    | Description              | Default
------    | -----------              | -------
install   | install package by npm   | yes
uninstall | uninstall package by npm |

#### Attributes

Attribute    | Description             | Default
---------    | -----------             | -------
name         | resource name           |
package      | node package name       |
version      | package version         | nil
node_version | node version            | nil
path         | install path to local   | nil
package_json | install by package.json | false

#### Examples

Install node package

```ruby
nodebrew_npm 'underscore'
```

Install node package with version

```ruby
nodebrew_npm 'underscore@1.5.1'
```
Install with option

```ruby
nodebrew_node 'underscore' do
  version '1.5.1'
  node_version '0.11.5'
  path '/var/www/app'
  package_json true
end
```

License and Author
------------------

MIT License

- [linyows][linyows]

[nodebrew]: https://github.com/hokaccha/nodebrew
[travis]: http://travis-ci.org/linyows/nodebrew-cookbook
[librarian]: https://github.com/applicationsonline/librarian#readme
[linyows]: https://github.com/linyows
