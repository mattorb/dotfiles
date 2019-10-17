-- luacheck: globals hs spoon hyper
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
local Install=spoon.SpoonInstall

hyper = {"cmd", "alt", "ctrl", "shift"}

Install:installSpoonFromZipURL('https://github.com/mattorb/MenuHammer/raw/master/Spoons/MenuHammer.spoon.zip')
local menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

Install:updateRepo('default')
Install:installSpoonFromRepo('Emojis')
Install:installSpoonFromRepo('KSheet')

local sheet = hs.loadSpoon('KSheet')
sheet:bindHotkeys({toggle={hyper, 'p'}})
local emojis = hs.loadSpoon('Emojis')
emojis.chooser:rows(15)
emojis:bindHotkeys({toggle={hyper, 'e'}})

require('keyboard')

-- working around some new os x nuance where this preference is not successfully preserved in the plist
--  after a relaunch of hammerspoonf
if hs.dockicon.visible() then
    hs.dockicon.hide()
end

require('menusearch')