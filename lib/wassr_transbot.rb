# -*- coding: utf-8 -*-
require "jabberbot"
require "gtrans"

class WassrTransBot < JabberBot
  attr_accessor :mode
  @mode = ""

  def receiver msg
    return unless  msg.body =~ /(.*): (.*) (>|&gt;) #{@mode}/
    sent = $1
    message = $2

    begin
      translated = GTrans::trans(message.gsub(/^@\S+ /, ""), @mode)
      sendmsg = "@#{sent} #{translated}"

      self.deliver(msg.from, sendmsg)
      self.logging "From:#{sent} msg:#{message} To:#{sendmsg}"
    rescue => e
      raise @mode + e
    end
  end
end
