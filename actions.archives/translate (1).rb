#!/bin/env ruby
# encoding: utf-8

module ActionTranslate

  include Action
  
  def translate q = nil

    if q.to_s == "" then return "! You must include a word to find a translation." end

    @target.dict.each do |word|
      if word['ENGLISH'].downcase == q.downcase then return "! The russian translation of \"#{q}\", is \"#{word['RUSSIAN']}\"." end
      if word['RUSSIAN'].downcase == q.downcase then return "! The english translation of \"#{q}\", is \"#{word['ENGLISH']}\"." end
    end

    return "! The dictionary does not include the word \"#{q}\"."

  end

end