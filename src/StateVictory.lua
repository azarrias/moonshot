StateVictory = Class{__includes=tiny.State}

function StateVictory:init(points)
  self.text = {
    { string = 'You win!', font = FONTS['retro-l'], textColor = {0.5, 0.1, 0.5} },
    { string = '\nPress space bar to play again', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
  self.points = points
end

function StateVictory:enter()
end

function StateVictory:update(dt)
  if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
    gameManager:Pop() -- self
    gameManager:Pop() -- play state
    gameManager:Push(StateStart())
  end
end

function StateVictory:render()
  RenderCenteredText(self.text)
end