-- luacheck: globals hs spoon hyper nohyper
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
local Install=spoon.SpoonInstall

hyper = {"cmd", "alt", "ctrl", "shift"}
ultra = { "ctrl", "alt", "cmd" }
nohyper = {"alt"}

Install:updateRepo('default')

-- Emojis selector. alt-e
Install:installSpoonFromRepo('Emojis')
local emojis = hs.loadSpoon('Emojis')
emojis.chooser:rows(15)
emojis:bindHotkeys({toggle={nohyper, 'e'}})

-- Hotkey cheatsheet.  alt-p
Install:installSpoonFromRepo('KSheet')
local sheet = hs.loadSpoon('KSheet')
sheet:bindHotkeys({toggle={nohyper, 'p'}})

-- Super Duper mode (hold s and d), Ah Fudge mode (hold a and f). Hold 5 seconds for help.
require('keyboard')

-- Menu item search.  alt-o
require('menusearch')

-- Draw on screen. ctrl-alt-cmd+c/a/t.  (c)lear/(a)nnotate/(t)oggle
local drawonscreen = require('drawonscreen')
local hotkey = hs.hotkey.modal.new(ultra, 'a')

function hotkey:entered()
  drawonscreen.start()
  drawonscreen.startAnnotating()
end

function hotkey:exited()
  drawonscreen.stopAnnotating()
  drawonscreen.hide()
end

hotkey:bind(ultra, 'c', function() drawonscreen.clear() end)
hotkey:bind(ultra, 'a', function() hotkey:exit() end)
hotkey:bind(ultra, 't', function() drawonscreen.toggleAnnotating() end)

-- note: leave hide dock icon hidden unchecked in ventura in sys setting,
--  else it won't be able to show a window until user switches to app. unknown why.
if hs.dockicon.visible() then
  hs.dockicon.hide()
end