# -*- coding: utf-8 -*-
require 'rubygems'
require 'rtranslate'

#
#= wrapper class for rtranslate
# Translate sentences with googletransrate
#
#Authors:: gom
#
class GTrans
  #
  # define to use language
  #
  Mode = {:ja=>Language::JAPANESE,
          :en=>Language::ENGLISH}

  # ==execute transration
  #
  # [sentence] sentence that want to translate
  # [from] language
  # [to] language
  #
  # [return] translated sentences
  #
  def self.trans sentence,mode
    mode =~ /(\w{2})2(\w{2})/
    return "no Transrate Mode!" if $1==nil

    from = Mode[$1.to_sym]
    to = Mode[$2.to_sym]
    begin
      result = Translate.t(sentence, from, to)
    rescue => e
      return "Error: no Transrate Mode!"
    end

  end
end
