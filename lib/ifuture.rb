require 'ichannel'
require 'ifuture/version'

class IFuture
  def initialize serializer = Marshal
    @channel = IChannel.new serializer
    pid = fork do
      @channel.put yield
    end
    @thread = Process.detach pid
  end
  
  def ready?
    defined?(@value) ? true : @channel.readable?
  end
  
  def value
    return @value if defined?(@value)
    
    @thread.join
    @value = @channel.get
  end
end