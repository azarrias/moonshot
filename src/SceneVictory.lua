SceneVictory = Class{__includes=tiny.Scene}

function SceneVictory:init()
  self.text = {
    { string = 'You win!', font = FONTS['retro-l'], textColor = {0.5, 0.1, 0.5} },
    { string = '\nPress space bar to play again', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
  self.level = nil
  self.points = nil
end

function SceneVictory:enter(params)
  self.level = params.level
  self.points = params.points
end

function SceneVictory:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    sceneManager:change('start')
  end
end

function SceneVictory:render()
  RenderCenteredText(self.text)
end