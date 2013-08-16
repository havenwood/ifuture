require 'ichannel'
require 'ifuture/version'

class IFuture
  def self.unix(serializer = Marshal, options = {}, &block)
    allocate.tap do |obj|
      obj.send :initialize, IChannel.unix(serializer, options), block
    end
  end

  def self.redis(serializer = Marshal, options = {}, &block)
    allocate.tap do |obj|
      obj.send :initialize, IChannel.redis(serializer, options), block
    end
  end

  def initialize(channel, block)
    @channel = channel
    @pid = fork { @channel.put(block.call) }
  end
  private_class_method :new

  def ready?
    if defined? @value
      true
    else
      @channel.readable?
    end
  end
  
  def value
    if defined? @value
      @value
    else
      Process.wait @pid
      @value = @channel.get
    end
  end
end
