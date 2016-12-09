#!/bin/env ruby
# encoding: utf-8

module ActionSay

  include Action
  
  def say q = nil

    _room = "#{@actor.parent}".prepend("0",5)
    _id   = "#{@actor.id}".prepend("0",5)
    _name = "#{@actor.name}".append(" ",14)

    flatten = "#{_room}-#{_id}-#{Timestamp.new.to_s} #{_name} #{q}\n"

    Memory_Array.new("forum").append(flatten)
    return "+ Added message: #{q}"

  end

end