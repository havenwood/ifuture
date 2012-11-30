require 'ifuture/version'
require 'ichannel'

class IFuture
  def initialize serializer = Marshal, &block
    @channel = IChannel.new serializer
    
    @pid = fork do
      @channel.put block.call
    end
  end
  
  def ready?
    begin
      !Process.getpgid(@pid)
    rescue Errno::ESRCH
      true
    end
  end
  
  def value
    Process.wait @pid
    @channel.get
  end
end