StateStart = Class{__includes = tiny.State} 
  
function StateStart:init()
  self.titleTextColor = {0, 0, 0, 0}
  self:SetText()
  self.fadeOut = nil
  self.fadeOutDuration = 1
  self.canInput = false
  self.pods = {}
  self.podsSpeed = 50
  
  self.teamText = "1916 underdogs presents"
  self.teamTextColor = {0, 0, 0, 1}
  
  self.printGameTitle = false
  
  local fadeInDuration = 2
  self.fadeIn = Fade({0, 0, 0, 1}, {0, 0, 0, 0}, fadeInDuration, function() end)
  
  Timer.after(3, function() 
    self.printGameTitle = true 
    Timer.tween(2, {
      [self.teamTextColor] = { 0, 0, 0, 0 },
      [self.titleTextColor] = { 0, 0, 0, 1 }
    })
    :finish(function() self.canInput = true end)
  end)
  
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
  love.graphics.setColor(self.teamTextColor)
  love.graphics.setFont(FONTS['retroville-m'])
  love.graphics.printf(self.teamText, 0, VIRTUAL_SIZE.y * 0.2, VIRTUAL_SIZE.x, 'center')
  
  if self.printGameTitle then
    RenderCenteredText(self.text)
  end
  
  if self.fadeIn then
    self.fadeIn:render()
  end
  if self.fadeOut then
    self.fadeOut:render()
  end
end

function StateStart:SetText()
  self.text = {
    { string = "Zoom to the\nMoon", font = FONTS['retro-l'], textColor = self.titleTextColor },
    { string = '\n\n\n\n\n\nPress space bar to start', font = FONTS['retroville-s'], textColor = self.titleTextColor }
  }
end

function StateStart:CreatePod(pos)
  local pod = tiny.Entity(pos.x, pos.y, 0, 0.5, 0.5)
    
  local sprite = tiny.Sprite(TEXTURES['pod'])
  pod:AddComponent(sprite)
  
  return pod
end