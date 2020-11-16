StateStart = Class{__includes = tiny.State} 
  
function StateStart:init()
  self.text = {
    { string = GAME_TITLE, font = FONTS['retro-l'], textColor = {0, 0, 0} },
    { string = '\nPress space bar to start', font = FONTS['retroville-s'], textColor = {0, 0, 0} }
  }
end

function StateStart:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    gameManager:Pop()
    gameManager:Push(StatePlay())
  end
end

function StateStart:render()
  --love.graphics.clear(0.5, 0.1, 0.1)
  love.graphics.clear(0.5, 0.1, 0.5)
  RenderCenteredText(self.text)
end
