FIXED_X = 600  -- Fixed x coordinate for the button
TIME_INTERVAL = 200  -- Time interval for the event call
MOVE_SPEED = 20  -- Speed at which the button moves to the left

local moveButtonEv = nil -- Event variable to keep track of the scheduled event so we can clear it later when the script is terminated

function moveButtonToLeft(button)
  local parent = button:getParent()
  local parentPosition = parent:getPosition()
  local oldPos = button:getPosition()
  local newX = oldPos.x - MOVE_SPEED  -- Calculate new X coordinate

  if newX < parentPosition.x then
        -- Reset button to a random position on the left once it crosses the parent's left boundary
        local parentHeight = parent:getHeight()
        local randomY = math.random(parentPosition.y, parentPosition.y + parentHeight - button:getHeight())
        oldPos.x = parentPosition.x + FIXED_X
        oldPos.y = randomY
        button:setPosition(oldPos)
  else
      -- Update button's position to move it to the left
      oldPos.x = newX
      button:setPosition(oldPos)
  end
  -- Reschedule the function to keep the button moving (I am not sure if there are timers in otclient, so I am using scheduleEvent to simulate it)
  moveButtonEv = scheduleEvent(function() moveButtonToLeft(button) end, TIME_INTERVAL)
end
function terminate()
  if moveButtonEv then
    stopEvent(moveButtonEv)  -- Stop the scheduled event if it's running
    moveButtonEv = nil
  end

  local ui = g_ui.getRootWidget()
  if ui then
    local mainWindow = ui:recursiveGetChildById('MainWindow')
    if mainWindow then
      mainWindow:destroy()  -- Ensure that the main window is destroyed
    end
  end
end
function init()
  local ui = g_ui.displayUI('random_button.otui')
  if not ui then
    return
  end

  local button = ui:getChildById('randomButton')
  if not button then
    return
  end

  -- Schedule the initial movement of the button
  moveButtonToLeft(button)

  button.onClick = function()
    -- Reposition the button randomly along Y within the parent, fixed along X
    local parent = button:getParent()
    local parentPosition = parent:getPosition()
    local parentHeight = parent:getHeight()
    local randomY = math.random(parentPosition.y, parentPosition.y + parentHeight - button:getHeight())
    button:setPosition({
      x = parentPosition.x + FIXED_X,
      y = randomY
    })
    button:setVisible(true) -- I am not sure if this is necessary but I am adding it just in case
    ui:recursiveGetChildById('MainWindow'):updateLayout() -- Same as previous, it's been a chaos to get the button visible with the teleports
  end
end
