local cache  = {}
local module = { cache = cache }

local COLOR     = { red = 200, green = 0, blue = 0, alpha = 0.8 }
local COLOR_DIM = { red = 200, green = 0, blue = 0, alpha = 0.4 }

-- grabs screen with active window, unless it's Finder's desktop - then defaults to mouse position
local activeScreen = function()
  local activeWindow = hs.window.focusedWindow()

  if activeWindow and activeWindow:role() ~= 'AXScrollArea' then
    return activeWindow:screen()
  else
    return hs.mouse.getCurrentScreen()
  end
end

local updateMode = function()
  local mouse = hs.mouse.getRelativePosition()
  local x, y  = mouse.x, mouse.y
  local color = cache.isAnnotating and COLOR or COLOR_DIM

  cache.canvas[1] = {
    center    = { x = x + 6, y = y - 6 },
    type      = 'circle',
    radius    = 3,
    action    = 'fill',
    fillColor = color,
  }
end

module.startAnnotating = function()
  local upsertCurrentDrawing = function(x, y)
    table.insert(cache.currentSegments, { x = x, y = y })

    cache.canvas[cache.currentId] = {
      id          = cache.currentId,
      type        = 'segments',
      coordinates = cache.currentSegments,
      action      = 'stroke',
      strokeColor = COLOR,
      strokeWidth = 2,
    }
  end

  -- empty callback with mouse events "catches" the input
  cache.canvas
    :canvasMouseEvents(false, false, false, true)
    :mouseCallback(function(_, _, _, _, _) end)

  -- actual drawing event - mouse dragged
  cache.tapDrag = hs.eventtap.new({
    hs.eventtap.event.types.leftMouseDown,
    hs.eventtap.event.types.leftMouseDragged
  }, function(e)
    -- TODO: marge `tapMove` and `tapDrag`, could recognise based on `eventType`
    local frame         = cache.canvas:frame()
    local eventType     = e:getType()
    local eventLocation = e:location()
    local x             = eventLocation['x'] - frame.x
    local y             = eventLocation['y'] - frame.y

    if eventType == hs.eventtap.event.types.leftMouseDown then
      cache.currentId       = cache.currentId + 1
      cache.currentSegments = {}

      upsertCurrentDrawing(x, y)
    elseif eventType == hs.eventtap.event.types.leftMouseDragged then
      upsertCurrentDrawing(x, y)
    end

    cache.canvas[1].center = { x = x + 6, y = y - 6 }
  end)

  cache.tapDrag:start()

  cache.isAnnotating = true

  updateMode()
end

module.stopAnnotating = function()
  if cache.canvas then
    cache.canvas
      :canvasMouseEvents(false, false, false, false)
      :mouseCallback(nil)
  end

  if cache.tapDrag then
    cache.tapDrag:stop()
    cache.tapDrag = nil
  end

  cache.isAnnotating = false

  updateMode()
end

local setup = function()
  if not cache.canvas then
    cache.canvas = hs.canvas.new({ x = 0, y = 0, w = 0, h = 0 })
      :level(hs.canvas.windowLevels.overlay)
      :behavior({
        hs.canvas.windowBehaviors.transient,
        hs.canvas.windowBehaviors.moveToActiveSpace
      })
  end

  local screen = activeScreen()

  cache.canvas
    :size(screen:frame())
    :frame(screen:frame())
    :show()

  cache.currentId = math.max(#cache.canvas, 1)

  if cache.tapMove then
    cache.tapMove:stop()
  end

  cache.tapMove = hs.eventtap.new({
    hs.eventtap.event.types.mouseMoved
  }, function(e)
    local frame         = cache.canvas:frame()
    local eventLocation = e:location()
    local x             = eventLocation['x'] - frame.x
    local y             = eventLocation['y'] - frame.y

    if cache.canvas[1] then
      cache.canvas[1].center = { x = x + 6, y = y - 6 }
    end
  end)

  cache.tapMove:start()

  updateMode()
end

module.start = function()
  setup()
end

module.clear = function()
  if cache.canvas then
    local wasAnnotating = cache.isAnnotating

    if wasAnnotating then
      module.stopAnnotating()
    end

    cache.canvas:delete()
    cache.canvas = nil

    setup()

    if wasAnnotating then
      module.startAnnotating()
    end
  end
end

module.toggleAnnotating = function()
  if cache.isAnnotating then
    module.stopAnnotating()
  else
    module.startAnnotating()
  end
end

module.hide = function()
  cache.canvas:hide()
  cache.tapMove:stop()
end

module.stop = function()
  if cache.canvas then
    cache.canvas:delete()
    cache.canvas = nil
  end

  if cache.tapDrag then
    cache.tapDrag:stop()
    cache.tapDrag = nil
  end

  if cache.tapMove then
    cache.tapMove:stop()
    cache.tapMove = nil
  end
end

return module
