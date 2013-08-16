require 'ichannel'
require 'ifuture/version'

class IFuture
  def initialize serializer = Marshal, transport = :unix, options = nil
    @channel = IChannel.send transport, serializer, options
    @pid = fork { @channel.put yield }
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
      Process.wait @pid
      @value = @channel.get
    end
  end
end
