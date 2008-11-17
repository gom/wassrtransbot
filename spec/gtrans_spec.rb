# -*- coding: utf-8 -*-
require 'gtrans'

describe GTrans do
  describe "when translating" do
    it "should translate English to Japanese" do
      str = 'test'
      GTrans::trans(str,:en,:jp).should == '試験'
    end

    it "should translate Japanese to English" do
      str = '試験'
      GTrans::trans(str,:jp,:en).should == 'Test'
    end
  end
  
  describe "when it have no mode" do
    it "should be error" do
      str = 'test'
      GTrans::trans(str,:en,:ja).should_not == '試験'
    end
  end
end
