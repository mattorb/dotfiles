hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

hyper = {"cmd", "alt", "ctrl", "shift"}

spoon.SpoonInstall:installSpoonFromZipURL('https://github.com/mattorb/MenuHammer/raw/master/Spoons/MenuHammer.spoon.zip')
menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

spoon.SpoonInstall:installSpoonFromRepo("Emojis")
emojis = hs.loadSpoon('Emojis')
emojis:bindHotkeys({toggle={hyper, 'e'}})

--
-- Useful when testing changes: reload hammerspoon config
--
-- hs.hotkey.bind(hyper, "R", function()
--   hs.reload()
-- end)

-- hs.alert.show("Hammerspoon config loaded")

require('keyboard')

-- working around some new os x nuance where this preference is not successfully preserved in the plist
--  after a relaunch of hammerspoonf
if hs.dockicon.visible() then
    hs.dockicon.hide()
end