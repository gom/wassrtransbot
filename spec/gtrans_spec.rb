# -*- coding: utf-8 -*-
require 'lib/gtrans'

describe GTrans do
  describe "when translating" do
    it "should translate English to Japanese" do
      str = 'test'
      GTrans::trans(str,"en2ja").should == '試験'
    end

    it "should translate Japanese to English" do
      str = '試験'
      GTrans::trans(str,"ja2en").should == 'Test'
    end
  end

  describe "when it have no mode" do
    it "should be error" do
      str = 'test'
      GTrans::trans(str,"striked").should_not == '試験'
    end
  end
end
