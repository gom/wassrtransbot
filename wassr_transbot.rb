# -*- coding: utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__)
require "jabberbot"
require "gtrans"

class WassrTransBot < JabberBot
  attr_accessor :mode
  @mode = ""
  ERROR_MSG = "Error!"

  def process msg
    if msg.body =~ /(.*): @#{@mode} (.*) > /
      sent = $1
      message = $2

      t = GTrans.new
      case @mode.to_sym
      when :ja2en
        after = t.trans(message,:jp,:en)
      when :en2ja
        after = t.trans(message,:en,:jp)
      else
        after = ERROR_MSG
      end
      sendmsg = "@#{sent} #{after}"

      puts <<EOL
--
#{Time.now.to_s}
:From #{sent} msg:#{message}
:To #{sendmsg}

EOL
      @client.deliver(msg.from, sendmsg)
    end
  end
end
