SceneStart = Class{__includes = tiny.Scene} 
  
function SceneStart:init()
  self.text = {
    { string = GAME_TITLE, font = FONTS['retro-l'], textColor = {0, 0, 0} },
    { string = '\nPress space bar to start', font = FONTS['retroville-s'], textColor = {0, 0, 0} }
  }
end

function SceneStart:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    -- TODO: change to 'play' scene
  end
end

function SceneStart:render()
  love.graphics.clear(0.5, 0.1, 0.1)
  RenderCenteredText(self.text)
end
