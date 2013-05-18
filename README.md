# iFuture
[![Build Status](https://secure.travis-ci.org/Havenwood/ifuture.png?branch=master)](http://travis-ci.org/havenwood/ifuture)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Havenwood/ifuture)

Futures for Ruby implemented with [IChannel](https://github.com/robgleeson/ichannel) for interprocess communication via a UNIXSocket or Redis. Run some code in another process, locally or over the network, and get the result back later!

The Future starts running right away, but isn't blocking because it runs in its own fork and uses IChannel to communicate with the parent Process. This allows multithreading without the GIL blocking as it would with Futures implemented on Threads. If the value is asked for and it is ready, it will be returned right away. If the value is asked for early, the Future blocks until delivery.

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
### Serializer

The default serialization format is Marshal, but you can use JSON, YAML or other formats that implement the methods #load and #dump.

```ruby
require 'json'

future = IFuture.new JSON do
  sleep 5
  :human_readable
end
```

### Transport

By default iFuture uses iChannel with unix sockets for transferring serialized code. To run your fork on a process located remoted over the network, you can specify that you want to you iChannel with Redis on a host of your choosing.

```ruby
future = IFuture.new(Marshal, :redis, {host: 'localhost', key: 'readme'}) do
  sleep 5
  :over_the_wire
end
```

## Installation

`gem install ifuture`

## Contributing

1. Fork it
2. Commit your changes
3. Create a pull request
