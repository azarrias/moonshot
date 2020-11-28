StateStart = Class{__includes = tiny.State} 
  
function StateStart:init()
  self:SetText()
  self.fadeOut = nil
  self.fadeOutDuration = 1
  self.canInput = true
  self.pods = {}
  self.podsSpeed = 50
  
--[[  local pod = self:CreatePod(tiny.Vector2D(VIRTUAL_SIZE.x * 0.8, VIRTUAL_SIZE.y * 0.15))
  table.insert(self.pods, pod)
  pod = self:CreatePod(tiny.Vector2D(VIRTUAL_SIZE.x * 0.17, VIRTUAL_SIZE.y * 0.69))
  table.insert(self.pods, pod)
  ]]
end

function StateStart:update(dt)
  if self.canInput then
    if love.keyboard.keysPressed['space'] or love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] or love.mouse.buttonReleased[1] then
      SOUNDS['new-game']:play()
      self.canInput = false
      Timer.every(0.2, function()
        self.text[2].textColor = {0, 0, 0, 0}
        Timer.after(0.08, function()
          self:SetText()
        end)
      end)
      Timer.after(2, function()
        self.fadeOut = Fade({0, 0, 0, 0}, {0, 0, 0, 1}, self.fadeOutDuration,
          function()
            gameManager:Pop()
            gameManager:Push(StateIntro())
          end)
      end)
    end
  end
  
  --[[for i = 1, #self.pods do
    self.pods[i].position.x = self.pods[i].position.x - self.podsSpeed * dt
  end]]
end

function StateStart:render()
  --love.graphics.clear(0.5, 0.1, 0.1)
  love.graphics.clear(0.5, 0.1, 0.5)
  
--[[  for i = 1, #self.pods do
    self.pods[i]:render()
  end
  ]]
  
  RenderCenteredText(self.text)
  if self.fadeOut then
    self.fadeOut:render()
  end
end

function StateStart:SetText()
  self.text = {
    { string = "Zoom to the\nMoon", font = FONTS['retro-l'], textColor = {0, 0, 0} },
    { string = '\n\n\n\n\n\nPress space bar to start', font = FONTS['retroville-s'], textColor = {0, 0, 0} }
  }
end

function StateStart:CreatePod(pos)
  local pod = tiny.Entity(pos.x, pos.y, 0, 0.5, 0.5)
    
  local sprite = tiny.Sprite(TEXTURES['pod'])
  pod:AddComponent(sprite)
  
  return pod
end