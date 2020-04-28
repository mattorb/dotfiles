-- luacheck: globals hs hyper nohyper
local log = hs.logger.new('menusearch', 'info')

local choiceCache = {}

local function menusearch_callback(item)
    if item then
        local menu_item_str = item['text']
        log.d('Selected ' .. menu_item_str)
        local app = hs.application.frontmostApplication()
        local menu_item = app:findMenuItem(menu_item_str)
        if menu_item then
            app:selectMenuItem(menu_item_str)
        end
    end
end

local chooser = hs.chooser.new(menusearch_callback)
chooser:rows(10)
chooser:searchSubText(true)
chooser:placeholderText('menu item name')

local function tablemerge(t1,t2)
    for _,v in ipairs(t2) do
        table.insert(t1, v)
    end

    return t1
end

-- Generates a case insensitive [Pp][Aa][Tt][Tt][Ee][Rr][Nn] match string
local function nocasePattern (s)
    s = string.gsub(s, "%a", function (c)
          return string.format("[%s%s]", string.lower(c),
                                         string.upper(c))
        end)
    return s
end

local commandEnum = {
    cmd = '⌘',
    shift = '⇧',
    alt = '⌥',
    ctrl = '⌃',
}

local function generateModifierString(menuitem)
    local CmdModifiers = ''
    for _, value in pairs(menuitem.AXMenuItemCmdModifiers) do
        CmdModifiers = CmdModifiers .. commandEnum[value]
    end
    local CmdChar = menuitem.AXMenuItemCmdChar
    local CmdGlyph = hs.application.menuGlyphs[menuitem.AXMenuItemCmdGlyph] or ''
    local CmdKeys = CmdChar .. CmdGlyph
    return CmdModifiers .. CmdKeys
end

local function processMenuItems(menustru)
    local choices = {}

    for _,val in pairs(menustru) do
        if type(val) == "table" then
            if val.AXRole == "AXMenuBarItem" and type(val.AXChildren) == "table" then
                log.d('parsing Menu Item Children for bar item ' .. val.AXTitle)
                local submenuItems = processMenuItems(val.AXChildren[1])
                choices = tablemerge(choices, submenuItems)
            elseif val.AXRole == "AXMenuItem" and not val.AXChildren then
                if not (val.AXMenuItemCmdChar == '' and val.AXMenuItemCmdGlyph == '') then
                    local shortcut = generateModifierString(val)

                    log.d('Adding Menu Item' .. val.AXTitle)
                    table.insert(choices, { text = val.AXTitle, subText=shortcut })
                elseif #val.AXTitle > 0 then
                    table.insert(choices, { text = val.AXTitle, subText='' })
                end
            elseif val.AXRole == "AXMenuItem" and type(val.AXChildren) == "table" then
                log.d('parsing Menu Item Children for ' .. val.AXTitle)
                choices = tablemerge(choices, processMenuItems(val.AXChildren[1]))
            end
        end
    end

    return choices
end

local function getCurrentAppMenuItems(app)
    return function ()
        if next(choiceCache) == nil then -- choiceCache is empty.  Populate.
            log.d('Populating menu item cache for app')
            choiceCache = processMenuItems(app:getMenuItems())
        end

        local filteredChoices = {}
        local filterString = chooser:query()

        for _,val in pairs(choiceCache) do
            if string.find(val["text"], nocasePattern(filterString)) then
                table.insert(filteredChoices, val)
            end
        end

        return filteredChoices
    end
end

local function queryChange(a)
    chooser:refreshChoicesCallback()
end

chooser:queryChangedCallback(queryChange)

hs.hotkey.new(
    nohyper,
    "o",
    function()
        if chooser:isVisible() then
            chooser:hide()
            choiceCache = {}
        else
            local app = hs.application.frontmostApplication()

            choiceCache = {}
            chooser:query(nil)

            -- todo: there is still a slight delay before items are refreshed because fetching all menu items is slow
            chooser:choices(getCurrentAppMenuItems(app))
            chooser:show()
        end
    end
):enable()

log.d('Menu Search loaded')