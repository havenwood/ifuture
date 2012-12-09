require 'ichannel'
require 'ifuture/error'
require 'ifuture/version'

class IFuture
  def initialize serializer = Marshal, &block
    raise Error::BlockMissing unless block_given?
    
    @channel = IChannel.new serializer
    @pid = fork do
      @channel.put block.call
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