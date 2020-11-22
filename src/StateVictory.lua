StateVictory = Class{__includes=tiny.State}

function StateVictory:init(playState, textDelay)
  self.text = {
    { string = 'You win!', font = FONTS['retro-l'], textColor = {0.5, 0.1, 0.5} },
    { string = '\nPress space bar to play again', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
  self.playState = playState
  self.displayText = false
  Timer.after(textDelay, function() self.displayText = true end)
end

function StateVictory:enter()
end

function StateVictory:update(dt)
  self.playState.level:update(dt)
  self.playState.player:update(dt)
  if self.displayText then
    if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
      gameManager:Pop() -- self
      gameManager:Pop() -- play state
      gameManager:Push(StateStart())
    end
  end
end

function StateVictory:render()
  if self.displayText then
    RenderCenteredText(self.text)
  end
end