# ifuture
[![Build Status](https://secure.travis-ci.org/havenwood/ifuture.png?branch=master)](http://travis-ci.org/havenwood/ifuture)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Havenwood/ifuture)

ifuture is a Futures gem for Ruby that use processes forking rather than threads. This allows parallelism with MRI without the GIL blocking as it might with threads. ifuture is implemented with [IChannel](https://github.com/robgleeson/ichannel) for interprocess communication over a Unix socket or Redis. Run your code in another process and get the result back later!

The Future starts running right away, but isn't blocking because it runs in its own forked process and uses ichannel to communicate with the parent process. If the value is asked for and it is ready, it will be returned right away. If the value is asked for early, the Future blocks until delivery.

## Installation

`gem install ifuture`

The Redis gem is required as well if you opt to use Redis instead of the default Unix socket transporter.

`gem install redis`

## Usage

```ruby
require 'ifuture'
future = IFuture.unix Marshal do
  sleep 2
  'result back from the child process!'
end

future.ready? #=> false
sleep 2
future.ready? #=> true
future.value #=> "result back from the child process!"
```

### Code Serialization Format

The default serialization format is Marshal, but you can use JSON, YAML or other formats that implement the methods #load and #dump.

```ruby
require 'ifuture'
require 'json'
future = IFuture.unix JSON do
  sleep 2
  {ok: true}
end
future.value #=> {"ok"=>true}
```

### IPC Transporter

By default ifuture uses ichannel with unix sockets for transferring serialized code. An alternate choice is to use ichannel with Redis, locally or over the network.

```ruby
require 'ifuture'
future = IFuture.redis Marshal, {host: 'localhost', key: 'readme'} do
  sleep 5
  42
end
future.value #=> 42
```

## Contributing

1. Fork it
2. Commit your changes
3. Create a pull request
4.  :cake:
