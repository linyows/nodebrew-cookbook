Nodebrew Cookbook
=================

Installs and manages your versions of Node.js in Chef with [nodebrew](https://github.com/hokaccha/nodebrew)

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
      { :version => 'v0.11.5' },
      { :version => 'v0.10.15', :binary => true }
    ],
    :using => 'v0.10.15',
    :npm => {
      'v0.11.5' => [
        'underscore',
        'coffee-script'
      ],
      'v0.10.15' => [
        'underscore',
        'async@0.2.9',
        { :name => 'bower', :version => '1.1.2', :action => 'install' }
      ]
    }
  }
)
```

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

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Authors
-------

- [linyows](https://github.com/linyows)

License
-------

MIT
