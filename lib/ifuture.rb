require 'ichannel'
require 'ifuture/error'
require 'ifuture/version'

class IFuture
  def initialize serializer = Marshal
    @channel = IChannel.new serializer
    @pid = fork do
      @channel.put yield
    end
  end
  
  def ready?
    defined?(@value) ? true : @channel.readable?
  end
  
  def value
    return @value if defined?(@value)
    
    Process.wait @pid
    @value = @channel.get
  end
end