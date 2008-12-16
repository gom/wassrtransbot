# -*- coding: utf-8 -*-
require 'wassr_transbot'
require 'yaml'

YAMLFILE = 'spec/test.yaml'

# Test Class for Send/Receive Message
class TestBot < WassrTransBot
  public :deliver, :receiver, :close
end

describe WassrTransBot, "with running" do
  before :all do
    data = YAML.load_file(YAMLFILE)
    @filename='received.log'
    @user1 = data['test1']['id']
    @pass1 = data['test1']['pass']
    @user2 = data['test2']['id']
    @pass2 = data['test2']['pass']
    @wassr = WassrTransBot.new(@user1,@pass1)
    @test = TestBot.new(@user2, @pass2)
  end

  def testres msg, result
    usrname = "Test"
    @test.deliver @user1,"#{usrname}: #{msg} > #{@wassr.mode}"
    sleep 3
    File.open(@filename,"r"){|f|
      s=f.readlines[-1]
      s=~/(From:#{usrname} msg:#{msg}).*(#{result})/
    }
     $2
  end

  it "should translate Japanese to English" do
    @wassr.mode = 'ja2en'
    msg = '試験'
    result = 'Test'
    testres(msg,result).should_not == nil
  end

  it "should translate English to Japanese" do
    @wassr.mode = "en2ja"
    msg = 'test'
    result = '試験'
    testres(msg,result).should_not == nil
  end

  it "should translate Japanese to English with @" do
    @wassr.mode = 'ja2en'
    msg = '@foo 試験'
    result = 'Test'
    testres(msg,result).should_not == nil
  end

  it "should translate English to Japanese with @" do
    @wassr.mode = "en2ja"
    msg = '@foo test'
    result = '試験'
    testres(msg,result).should_not == nil
  end

  after :all do
    @wassr = nil
    @test = nil
    File.open(@filename,"w"){|f| }
  end
end
