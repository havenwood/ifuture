require 'ifuture/version'
require 'ichannel'

class IFuture
  def initialize &block
    @channel = IChannel.new Marshal
    
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