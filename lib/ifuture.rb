require 'ifuture/version'
require 'ichannel'

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
    if defined?(@value)
      return @value
    end
    Process.wait @pid
    @value = @channel.get
  end
end
