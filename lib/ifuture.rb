require 'ichannel'
require 'ifuture/version'

class IFuture
  def self.unix(serializer, options = {})
    new(serializer, :unix, options)
  end

  def self.redis(serializer, options = {})
    new(serializer, :redis, options)
  end

  def initialize(serializer = Marshal, transport = :unix, options = {})
    @channel = IChannel.send transport, serializer, options
    @thread = Process.detach fork { @channel.put yield }
  end
  
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
      @thread.join
      @value = @channel.get
    end
  end
end
