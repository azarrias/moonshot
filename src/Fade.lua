Fade = Class{}

function Fade:init(fromColor, toColor, transitionTime, onFadeComplete)
  self.enabled = true
  
  self.r = fromColor[1]
  self.g = fromColor[2]
  self.b = fromColor[3]
  self.a = fromColor[4] or 1
  
  Timer.tween(transitionTime, {
    [self] = { r = toColor[1], g = toColor[2], b = toColor[3], a = toColor[4] or 1 }
  })
  :finish(function()
    self.enabled = false
    onFadeComplete()
  end)
end

function Fade:render()
  if self.enabled then
    love.graphics.setColor(self.r, self.g, self.b, self.a)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_SIZE.x, VIRTUAL_SIZE.y)
    love.graphics.setColor(1, 1, 1, 1)
  end
end