# -*- coding: utf-8 -*-
require "rubygems"
require "xmpp4r-simple"

#
#= Jabber Client for auto messaging
# automatic responce to the message
#
class JabberBot
  # Error Messages
  CONNECTOR_ERR = "I can't make the connect: "
  RECEIVER_ERR = "I can't receive the message: "
  DELIVER_ERR = "I can't delivery the message: "
  DISCONNECTOR_ERR = "I can't leave the server...: "

  LOG_FILE = "received.log"

  #
  #===Constractor
  # connect to Jabber Server, add callback process
  #[user] account name for connecting jabber
  #[pass] the account's password
  #
  def initialize user,pass
    begin
      @client = Jabber::Simple.new(user,pass)
    rescue => e
      raise CONNECTOR_ERR + e
    end
    @client.client.add_message_callback {|msg|
      begin
        self.receiver msg
      rescue => e
        self.logging "[#{Time.now}]#{$0}: #{e.class} > #{e}"
        raise RECEIVER_ERR + e
      end
    }
  end

  #
  #=== Start JabberBot with Daemon
  #
  def self.daemon &bl
    begin
      return yield if $DEBUG
      fork {
        Process.setsid
        pidfile = "#{$0}.pid"
        open(pidfile,'w') {|f| f << Process.pid }
        fork {
          File::umask(0)
          Dir::chdir('/')
          File.open('/dev/null'){|f|
            STDIN.reopen f
            STDOUT.reopen f
            STDERR.reopen f
          }
        }
        yield
      }
      exit! 0
    rescue => e
      self.logging "[#{Time.now}]#{$0}: #{e}"
    end
  end

  #
  #=== Connecting Check
  # if client is disconnected, try reconnecting.
  #
  def check
    begin
      unless @client.connected?
        self.logging "[#{Time.now}]Disconnected! Try Reconnecting!"
        @client.reconnect
      end
      @client.status(nil, "")
    rescue => e
      raise CONNECTOR_ERR + e
    end
  end

  protected
  #
  #=== Deliver a message to the client that sent message
  #[sent] client from the message
  #[msg] the message for delivering
  #
  def deliver sent,msg
    begin
      @client.deliver(sent, msg)
    rescue => e
      raise DELIVER_ERR + e
    end
  end

  #
  #=== Action for receiving messages
  #This method is only definition.
  #Inheritances can inplement this method.
  #
  #[msg] a received message
  #
  def receiver msg
    self.logging "received #{msg.body} from #{msg.from}"
  end

  #
  #=== Disconnecting jabber server
  #
  def close
    begin
      @client.disconnect
    rescue => e
      raise DISCONNECTOR_ERR + e
    end
  end

  #
  #=== logging any message
  #[msg] a logged message
  #
  def logging msg
    File.open(LOG_FILE, "a"){|f|
      f.puts "[#{Time.now}] #{$0}: #{msg}"
    }
  end
end
