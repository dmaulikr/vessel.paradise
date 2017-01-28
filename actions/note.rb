#!/bin/env ruby
# encoding: utf-8

class ActionNote

  include Action
  
  def initialize q = nil

    super

    @name = "Note"
    @docs = "TODO"

  end

  def act q = "Home"

    @host.parent.set_note(q)

    if q.length < 5
      @host.parent.set_note("")
      return "You have removed the #{@host.parent} note." 
    end

    return @host.act(:look,"You added a note to #{@host.parent}.")

  end

end