StateLevelClear = Class{__includes=tiny.State}

function StateLevelClear:init(playState, textDelay)
  self.text = {
    { string = 'Level clear!', font = FONTS['retro-l'], textColor = {0.5, 0.1, 0.5} },
    { string = '\nPress space bar to continue', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255} },
    { string = '\nESC to quit', font = FONTS['retroville-s'], textColor = {225 / 255, 225 / 255, 225 / 255}  }
  }
  self.playState = playState
  self.displayText = false
  Timer.after(textDelay, function() self.displayText = true end)
end

function StateLevelClear:enter()
end

function StateLevelClear:update(dt)
  self.playState.level:update(dt)
  self.playState.player:update(dt)
  if self.displayText then
    if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
      self.playState:NewLevel()
      gameManager:Pop()
    end
  end
end

function StateLevelClear:render()
  if self.displayText then
    RenderCenteredText(self.text)
  end
end