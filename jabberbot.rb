# -*- coding: utf-8 -*-
require "rubygems"
require "xmpp4r-simple"

class JabberBot
  ABORT_MSG = "aborting..."
  
  def initialize user,pass
    @client = Jabber::Simple.new(user,pass)
    Thread.start {
      @client.client.add_message_callback {|msg|
        self.process msg
      }
      self.check
      sleep 5
    }
  end

  def process msg
    # implement at child
  end

  def close from
    @client.deliver(from, ABORT_MSG)
    @client.disconnect
    puts ABORT_MSG + Time.now.to_s
    Thread.exit
  end

  def check
    @client.reconnect unless @client.connected?
  end

  protected :close, :process
end
