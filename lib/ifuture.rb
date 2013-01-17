require 'ichannel'
require 'ifuture/version'

class IFuture
  def initialize serializer = Marshal
    @channel = IChannel.new serializer
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
