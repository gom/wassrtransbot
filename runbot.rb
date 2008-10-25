#!/usr/bin/ruby
# -*- coding: utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__)
require "webrick"
require "wassr_transbot"

# Entry Point
mode = ARGV.shift
id = ARGV.shift
pass = ARGV.shift
WEBrick::Daemon.start {
  r = WassrTransBot.new(id,pass)
  r.mode = mode
  loop {
    sleep 1
  }
}
