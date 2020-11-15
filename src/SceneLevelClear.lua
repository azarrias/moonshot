SceneLevelClear = Class{__includes=tiny.Scene}

function SceneLevelClear:init()
  self.text = {
    { string = 'Level clear!', font = FONTS['retro-l'], textColor = {0.5, 0.1, 0.5} },
    { string = '\nPress space bar to continue', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
  self.level = nil
  self.points = nil
end

function SceneLevelClear:enter(params)
  self.level = params.level
  self.points = params.points
end

function SceneLevelClear:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    sceneManager:change('play', { points = self.points, level = self.level + 1 })
  end
end

function SceneLevelClear:render()
  RenderCenteredText(self.text)
end