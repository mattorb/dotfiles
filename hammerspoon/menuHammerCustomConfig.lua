-- luacheck: globals menuHammerMenuList cons hyper hs resolutionMenuItems nohyper

-- Menus
local mainMenu = "mainMenu"

-- Applications Menus
local applicationMenu = "applicationMenu"
local utilitiesMenu = "utilitiesMenu"

-- Browser menus
local browserMenu = "browserMenu"

-- Finder menu
local finderMenu = "finderMenu"

-- Hammerspoon menu
local hammerspoonMenu = "hammerspoonMenu"

-- -- Layout menu
-- local layoutMenu = "layoutMenu"

-- Resolution menu
local resolutionMenu = "resolutionMenu"

-- Text menu
local textMenu = "textMenu"

-- Toggles menu
local toggleMenu = "toggleMenu"

menuHammerMenuList = {

    ------------------------------------------------------------------------------------------------
    -- Main Menu
    ------------------------------------------------------------------------------------------------
    [mainMenu] = {
        parentMenu = nil,
        menuHotkey = { nohyper, 'space'},
        menuItems = {
            {cons.cat.submenu, '', 'A', 'Applications', {
                {cons.act.menu, applicationMenu}
            }},
            {cons.cat.submenu, '', 'B', 'Browser', {
                {cons.act.menu, browserMenu}
            }},
            {cons.cat.submenu, '', 'F', 'Finder', {
                {cons.act.menu, finderMenu}
            }},
            {cons.cat.submenu, '', 'H', 'Hammerspoon', {
                {cons.act.menu, hammerspoonMenu}
            }},
            -- {cons.cat.submenu, '', 'L', 'Layouts', {
            --      {cons.act.menu, layoutMenu}
            -- }},
            {cons.cat.submenu, '', 'T', 'Toggles', {
                 {cons.act.menu, toggleMenu}
            }},
            {cons.cat.submenu, '', 'X', 'Text', {
                 {cons.act.menu, textMenu}
            }},
            {cons.cat.action, '', 'space', "Spotlight", {
                {cons.act.keycombo, {'cmd'}, 'space'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Application Menu
    ------------------------------------------------------------------------------------------------
    applicationMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Chrome", {
                {cons.act.launcher, 'Google Chrome'}
            }},
            {cons.cat.action, '', 'F', "Finder", {
                {cons.act.launcher, 'Finder'}
            }},
            {cons.cat.action, '', 'S', "Safari", {
                {cons.act.launcher, 'Safari'}
            }},
            {cons.cat.action, '', 'T', "Terminal", {
                {cons.act.launcher, 'Terminal'}
            }},
            {cons.cat.submenu, '', 'U', 'Utilities', {
                {cons.act.menu, utilitiesMenu}
            }},
            {cons.cat.action, '', 'V', "VS Code", {
                {cons.act.launcher, 'Visual Studio Code'}
            }},
            {cons.cat.action, '', 'X', "Xcode", {
                {cons.act.launcher, 'Xcode'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Utilities Menu
    ------------------------------------------------------------------------------------------------
    utilitiesMenu = {
        parentMenu = applicationMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'A', "Activity Monitor", {
                {cons.act.launcher, 'Activity Monitor'}
            }},
            {cons.cat.action, 'shift', 'A', "Airport Utility", {
                {cons.act.launcher, 'Airport Utility'}
            }},
            {cons.cat.action, '', 'C', "Console", {
                {cons.act.launcher, 'Console'}
            }},
            {cons.cat.action, '', 'D', "Disk Utility", {
                {cons.act.launcher, 'Disk Utility'}
            }},
            {cons.cat.action, '', 'K', "Keychain Access", {
                {cons.act.launcher, 'Keychain Access'}
            }},
            {cons.cat.action, '', 'S', "System Information", {
                {cons.act.launcher, 'System Information'}
            }},
            {cons.cat.action, '', 'T', "Terminal", {
                {cons.act.launcher, 'Terminal'}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Browser Menu
    ------------------------------------------------------------------------------------------------
    browserMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Chrome", {
                {cons.act.launcher, 'Google Chrome'}
            }},
            {cons.cat.action, '', 'F', "Firefox", {
                {cons.act.launcher, 'Firefox'}
            }},
            {cons.cat.action, '', 'G', 'Google',
            {
                {cons.act.userinput,
                 "query",
                 "Google Search",
                 "Enter search criteria"},
                {cons.act.openurl,
                 "http://www.google.com/search?q=@@query@@"
                },
                {cons.act.openurl,
                "http://www.google.com/search?q=@@query@@&meta=&btnI"
               },
           }},
           {cons.cat.action, '', 'S', "Safari", {
               {cons.act.launcher, 'Safari'}
           }},
           {cons.cat.action, '', 'T', 'Copy Safari tab urls to Clipboard', {
            {
                cons.act.script, 
                "~/bin/safari_urls.osascript"},
            }},
        }
    },
    

    ------------------------------------------------------------------------------------------------
    -- Finder Menu
    ------------------------------------------------------------------------------------------------
    finderMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'D', 'Desktop', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'd'},
            }},
            {cons.cat.action, 'shift', 'D', 'Downloads', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'alt'}, 'l'},
            }},
            {cons.cat.action, '', 'F', "Finder", {
                {cons.act.launcher, 'Finder'}
            }},
            {cons.cat.action, '', 'G', 'Go to Folder...', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'g'},
            }},
            {cons.cat.action, '', 'H', 'Home', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'h'},
            }},
            {cons.cat.action, '', 'K', 'Connect to Server...', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd'}, 'K'},
            }},
            {cons.cat.action, '', 'N', 'Network', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'k'},
            }},
            {cons.cat.action, '', 'O', 'Documents', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'o'},
            }},
            {cons.cat.action, '', 'R', 'Recent', {
                {cons.act.launcher, 'Finder'},
                {cons.act.keycombo, {'cmd', 'shift'}, 'f'},
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Hammerspoon Menu
    ------------------------------------------------------------------------------------------------
    hammerspoonMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Hammerspoon Console", {
                {cons.act.func, function() hs.toggleConsole() end }
            }},
            {cons.cat.action, '', 'H', "Hammerspoon Manual", {
                {cons.act.func, function()
                      hs.doc.hsdocs.forceExternalBrowser(true)
                      hs.doc.hsdocs.moduleEntitiesInSidebar(true)
                      hs.doc.hsdocs.help()
                end }
            }},
            {cons.cat.action, '', 'R', "Reload Hammerspoon", {
                {cons.act.func, function() hs.reload() end }
            }},
            {cons.cat.action, '', 'Q', "Quit Hammerspoon", {
                {cons.act.func, function() os.exit() end }
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Layout Menu
    ------------------------------------------------------------------------------------------------
    -- [layoutMenu] = {
    --     parentMenu = mainMenu,
    --     menuHotkey = nil,
    --     menuItems = {
    --         {cons.cat.action, '', 'E', "Split Safari/iTunes", {
    --              {cons.act.func, function()
    --                   -- See Hammerspoon layout documentation for more info on this
    --                   local mainScreen = hs.screen{x=0,y=0}
    --                   hs.layout.apply({
    --                           {"Safari", nil, mainScreen, hs.layout.left50, nil, nil},
    --                           {"iTunes", nil, mainScreen, hs.layout.right50, nil, nil},
    --                   })
    --              end }
    --         }},
    --     }
    -- },


    ------------------------------------------------------------------------------------------------
    -- Open Files Menu
    ------------------------------------------------------------------------------------------------
    openFilesMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Resolution Menu
    ------------------------------------------------------------------------------------------------
    resolutionMenu = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = resolutionMenuItems
    },

    ------------------------------------------------------------------------------------------------
    -- Text Menu
    ------------------------------------------------------------------------------------------------
    [textMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', 'Remove clipboard format', {
                 {cons.act.func, function()
                      local pasteboardContents = hs.pasteboard.getContents()
                      hs.pasteboard.setContents(pasteboardContents)
                 end },
            }},
            {cons.cat.action, '', 'E', 'Empty the clipboard', {
                 {cons.act.func, function() hs.pasteboard.setContents("") end}
            }},
            {cons.cat.action, '', 'T', 'Type clipboard contents', {             -- need to slow this down to avoid conflicts with super duper and ah fudge mode (munges those character positions)
                 {cons.act.typetext, "@@mhClipboardText@@"}
            }},
        }
    },

    ------------------------------------------------------------------------------------------------
    -- Toggle menu
    ------------------------------------------------------------------------------------------------
    [toggleMenu] = {
        parentMenu = mainMenu,
        menuHotkey = nil,
        menuItems = {
            {cons.cat.action, '', 'C', "Caffeine", {
                 {cons.act.func, function() toggleCaffeine() end }
            }},
            {cons.cat.action, '', 'D', "Hide/Show Dock", {
                 {cons.act.keycombo, {'cmd', 'alt'}, 'd'}
            }},
            {cons.cat.action, '', 'S', "Start Screensaver", {
                 {cons.act.system, cons.sys.screensaver},
            }},
            {cons.cat.submenu, '', 'R', 'Resolution', {
                {cons.act.menu, resolutionMenu}
            }},
            {cons.cat.action, 'shift', 'W', "Disable wi-fi", {
                 {cons.act.func, function() hs.wifi.setPower(false) end }
            }},
            {cons.cat.action, '', 'W', "Enable wi-fi", {
                 {cons.act.func, function() hs.wifi.setPower(true) end }
            }},
        }
    },
}
