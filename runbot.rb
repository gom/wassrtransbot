#!/usr/bin/ruby
# -*- coding: utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__)
require "webrick"
require "wassr_transbot"
require "yaml"

# Entry Point
data = YAML.load(ARGF.read)
WEBrick::Daemon.start {
  r = WassrTransBot.new(data['id'],data['pass'])
  r.mode = data['mode']
  loop {
    sleep 10
  }
}
