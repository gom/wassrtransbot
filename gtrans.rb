# -*- coding: utf-8 -*-
require 'rubygems'
require 'rtranslate'

# execute Google Transrate with rtranslate
class GTrans
  Mode = {:jp=>Language::JAPANESE,
          :en=>Language::ENGLISH}

  # execute a transration
  # s: string
  # from: language for 
  # to: language
  def trans s,from,to # 翻訳
    begin
      @from = Mode[from.to_sym]
      @to = Mode[to.to_sym]
    rescue
      return "Error: no Transrate Mode!"
    end
    result = Translate.t(s, @from, @to)
  end
end

# entry
# ARGV[0]=from, [1]=to, [2]=sentence
#from = ARGV.shift
#to = ARGV.shift
#sentence = ARGV.shift

#t = GTrans.new
#puts t.trans(sentence,from,to)
