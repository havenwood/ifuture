# ifuture

An implementation of Futures for Ruby using process forks with IChannel.

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
