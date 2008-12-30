require 'lib/jabberbot'
require 'yaml'

#
#==it needs test.yaml for this spec
#
#ex.)
#test1:
#  id: hoge
#  pass: xxx
#test2:
#  id: hage
#  pass: yyy
#
YAMLFILE='spec/test.yaml'

describe JabberBot do
  describe "when initializing" do
    before do
      data = YAML.load_file(YAMLFILE)
      @user = data['test1']['id']
      @pass = data['test1']['pass']
    end

    it "should log in" do
      JabberBot.new(@user, @pass).class.should == JabberBot
    end
  end

  #
  # Test Class for Send/Receive Message
  #
  class TestBot < JabberBot
    public :deliver, :receiver, :close
  end

  describe "when running" do
    before :all do
      data = YAML.load_file YAMLFILE
      @filename="received.log"
      @user1 = data['test1']['id']
      @pass1 = data['test1']['pass']
      @user2 = data['test2']['id']
      @pass2 = data['test2']['pass']
      @jabber = JabberBot.new(@user1, @pass1)
    end

    it "should be checking connecting" do
      @jabber.check.should == nil
    end

    it "should deliver and receive messages" do
      test = TestBot.new(@user2,@pass2)
      msg="test"
      test.deliver @user1,msg
      sleep 3
      test=nil

      File.open(@filename,"r"){|f|
        s = f.readlines[-1]
        s=~/(received #{msg} from #{@user2})/
        $1.should_not == nil
      }
    end

    after :all do
      @jabber = nil
      File.open(@filename, "w"){|f| }
    end
  end
end
