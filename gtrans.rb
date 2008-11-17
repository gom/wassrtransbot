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
  Mode = {:jp=>Language::JAPANESE,
          :en=>Language::ENGLISH}

  # ==execute transration
  #
  # [sentence] sentence that want to translate
  # [from] language
  # [to] language
  #
  # [return] translated sentences
  #
  def self.trans sentence,from,to
    begin
      from = Mode[from.to_sym]
      to = Mode[to.to_sym]
    rescue => e
      return "Error: no Transrate Mode!"
    end
    result = Translate.t(sentence, from, to)
  end
end
