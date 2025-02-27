# Namespacing [![Build Status](https://travis-ci.org/jah2488/namespacing.png?branch=master)](https://travis-ci.org/jah2488/namespacing) [![Code Climate](https://codeclimate.com/github/jah2488/namespacing.png)](https://codeclimate.com/github/jah2488/namespacing)
[![Gem Version](https://badge.fury.io/rb/namespacing.png)](http://badge.fury.io/rb/namespacing)


Namespacing adds namespaces to Ruby by taking inspiration from how Clojure handles its namespaces.
It is primarly a simplification of the existing module syntax. Great for deeply nested modules or for attempting a more functional approach to writing Ruby code. I wrote [a blog post](https://web.archive.org/web/20141220065620/http://jah2488.roon.io/adding-namespaces-to-ruby-for-fun-and-practice) about the inspiration and process of creating this code.

## Installation

Add this line to your application's Gemfile:

    gem 'namespacing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install namespacing

## Usage

Simply require the gem and decide the scope you'd like to have it at. To use it in the global scope, you'll want to extend `Object`

```rb
require 'namespacing'

class Object
  include Namespacing
end

ns 'my_app.dojo.util.options' do
  def names
    %w(on off maybe 7 42 tuesday)
  end
end
```
Then this code can be called with: 
```rb
MyApp::Dojo::Util::Options.names 
#=> ['on', 'off', 'maybe', '7', '42', 'tuesday']
```

An optional delimiter can be passed in when defining your namespace. (I would recommend against using `_` as that delimiter.)
```rb
ns 'github|repositories|settings', '|' do
  def destroy!
    confirm
  end
end

Github::Repositories::Settings.destroy!
```



## Gotchas

There is at least one known and unexpected side effect. 

__Defining constants inside the `ns` block does not work as expected__. 
Any constants set will be at the top level namespace.
```rb
ns 'rails.active_support.version' do
  VERSION = '1.0.0'
end

Rails::ActiveSupport::Version #=> NameError: uninitialized constant Kernel::Rails::ActiveSupport::Version::VERSION
VERSION #=> '1.0.0'
```

There are currently two ways to define constants in the proper scoping to avoid this issue.

__Define the full scope of the constant__
```rb
ns 'rails.active.version' do
  Rails::Active::Version::MAJOR = 1
end

Rails::Active::Version::MAJOR #=> 1
```

__Use `const_set`__
```rb
ns 'rails.support.version' do
  const_set(:MAJOR, 1)
end

Rails::Support::Version::MAJOR #=> 1
```


## Contributing

1. Fork it ( http://github.com/<my-github-username>/namespacing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
