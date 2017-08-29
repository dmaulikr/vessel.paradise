#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpse","http")

$nataniev.vessel.path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

$nataniev.vessel.install(:custom,:serve)

corpse = CorpseHttp.new($nataniev.vessel)

corpse.add_meta("description","Multiplayer Interactive Fiction Multiverse")
corpse.add_meta("keywords","paradise maeve")
corpse.add_meta("viewport","width=device-width, initial-scale=1, maximum-scale=1")
corpse.add_meta("apple-mobile-web-app-capable","yes")
corpse.add_meta("apple-touch-fullscreen","yes")
corpse.add_meta("apple-mobile-web-app-status-bar-style","black-translucent")
corpse.add_link("reset.css",:lobby)
corpse.add_link("font.input_mono.css",:lobby)
corpse.add_link("font.lora.css",:lobby)
corpse.add_script("core/jquery.js",:lobby)
corpse.add_link("style.fonts.css")
corpse.add_link("style.main.css")
corpse.add_script("jquery.main.js")

$nataniev.vessel.corpse = corpse

def corpse.paradise ; return @paradise; end
def corpse.parade; return @parade; end
def corpse.player; return @player; end
def corpse.forum ; return @forum; end

def corpse.query q = nil

  load_folder("#{$nataniev.vessel.path}/objects/*")
  load_folder("#{$nataniev.vessel.path}/vessels/*")
  load_folder("#{$nataniev.vessel.path}/actions/*")

  @forum           = Memory_Array.new("forum",@host.path)
  @paradise        = Memory_Array.new("paradise",@host.path)
  @parade          = @paradise.to_a("teapot")

  id = 0
  @parade.each do |vessel|
    vessel.id = id
    id += 1
  end

  parts = q.gsub("+"," ").strip.split(" ")
  player_id = parts.first.to_i
  action = parts[1] ? parts[1] : "look"
  params = parts.join(" ").sub(player_id.to_s,"").sub(action,"").strip

  if player_id < 1 then return select_random_vessel end

  @player = @parade[player_id]
  @title   = "Paradise ∴ #{@player}"

  self.body = "<bg></bg><view>#{@player.act(action,params)}</view><div class='terminal'><input placeholder='What would you like to do?'/></div>"

end