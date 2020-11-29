require 'globals'

function love.load()
  if DEBUG_MODE then
    if arg[#arg] == "-debug" then 
      require("mobdebug").start() 
    end
    io.stdout:setvbuf("no")
  end
  
  math.randomseed(os.time())

  -- use nearest-neighbor (point) filtering on upscaling and downscaling to prevent blurring of text and 
  -- graphics instead of the bilinear filter that is applied by default 
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  -- Set up window
  push:setupScreen(VIRTUAL_SIZE.x, VIRTUAL_SIZE.y, WINDOW_SIZE.x, WINDOW_SIZE.y, {
    vsync = true,
    --vsync = false,
    fullscreen = not WEB_OS,
    resizable = not (MOBILE_OS or WEB_OS),
    stencil = not WEB_OS and true or false
  })
  love.window.setTitle(GAME_TITLE)
  
  -- use a stack for the game state machine
  -- this way, all data and behavior is preserved between state changes
  gameManager = tiny.StackFSM()
  gameManager:Push(StateStart())
  
  love.keyboard.keysPressed = {}
  love.mouse.buttonPressed = {}
  love.mouse.buttonReleased = {}
end

function love.update(dt)
  -- exit if esc is pressed
  if love.keyboard.keysPressed['escape'] then
    love.event.quit()
  end
  
  -- Update all timers in the default group
  Timer.update(dt)
  
  gameManager:update(dt)
  
  love.keyboard.keysPressed = {}
  love.mouse.buttonPressed = {}
  love.mouse.buttonReleased = {}
end

function love.resize(w, h)
  push:resize(w, h)
end
  
-- Callback that processes key strokes just once
-- Does not account for keys being held down
function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.mousepressed(x, y, button)
  love.mouse.buttonPressed[button] = true
end

function love.mousereleased(x, y, button)
  love.mouse.buttonReleased[button] = true
end

function love.draw()
  push:start()
  gameManager:render()
  
  -- draw fps indicator
  --[[
  local fps = love.timer.getFPS()
  if fps >= 60 then
    love.graphics.setColor(0, 1, 0)
  else
    love.graphics.setColor(1, 0, 0)
  end
  love.graphics.setFont(FONTS['retroville-s'])
  love.graphics.printf("FPS: " .. fps, 0, VIRTUAL_SIZE.y - 5 - love.graphics.getFont():getHeight(), VIRTUAL_SIZE.x - 5, 'right')
  ]]
  push:finish()
end