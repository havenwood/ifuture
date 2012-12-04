# ifuture
[![Build Status](https://secure.travis-ci.org/Havenwood/ifuture.png?branch=master)](http://travis-ci.org/Havenwood/ifuture)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Havenwood/ifuture)

An implementation of Futures (see [Celluloid](https://github.com/celluloid/celluloid)) for Ruby using process forks with [IChannel](https://github.com/robgleeson/ichannel).

The Future starts running right away, but isn't blocking because it runs in its own fork and uses IChannel to communicate with the parent Process. This allows multithreading without the GIL blocking as it would with Threads. If the value is asked for and it is ready, it will be returned right away. If the value is asked for early, the Future blocks until delivery.

## Usage

```ruby
future = IFuture.new do
  3.downto 0 do |n|
    sleep 1
    puts "#{n}..."
  end

  'Sekret!!'
end

future.ready?
#=> false

sleep 5
#=> 5

# 3...
# 2...
# 1...
# 0...

future.ready?
#=> true

future.value
#=> "Sekret!!"
```

## Installation

`gem install ifuture`

## Contributing

1. Fork it
2. Commit your changes
3. Create a pull request
