hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

hyper = {"cmd", "alt", "ctrl", "shift"}

spoon.SpoonInstall:installSpoonFromZipURL('https://github.com/mattorb/MenuHammer/raw/master/Spoons/MenuHammer.spoon.zip')
menuHammer = hs.loadSpoon("MenuHammer")
menuHammer:enter()

spoon.SpoonInstall:updateRepo('default')
spoon.SpoonInstall:installSpoonFromRepo('Emojis')
spoon.SpoonInstall:installSpoonFromRepo('KSheet')

sheet = hs.loadSpoon('KSheet')
sheet:bindHotkeys({toggle={hyper, 'p'}})
emojis = hs.loadSpoon('Emojis')
emojis.chooser:rows(15)
emojis:bindHotkeys({toggle={hyper, 'e'}})

require('keyboard')

-- working around some new os x nuance where this preference is not successfully preserved in the plist
--  after a relaunch of hammerspoonf
if hs.dockicon.visible() then
    hs.dockicon.hide()
end

require('menusearch')