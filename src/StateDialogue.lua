StateDialogue = Class{__includes = tiny.State}

function StateDialogue:init(speaker, text, callback)
  self.size = tiny.Vector2D(0.7 * VIRTUAL_SIZE.x, 0.2 * VIRTUAL_SIZE.y):Floor()
  self.leftMargin = math.floor((VIRTUAL_SIZE.x - self.size.x) / 2)
  self.bottomMargin = VIRTUAL_SIZE.y * 0.1

  self.speaker = speaker
  self.avatar = self:CreateAvatar()
  self.avatarAnimationTimer = Timer.after(0.5, 
    function()
      Timer.every(0.2, function()
      local sprite = self.avatar.components['Sprite']
      local r = math.random(0, 19)
      local quad_id = r - 14
      if r <= 17 then
        quad_id = math.floor(r / 6) + 1
      end
      sprite:SetDrawable(TEXTURES[self.speaker], QUADS[self.speaker][quad_id])
    end)
  end)

  self.textbox = Textbox(self.leftMargin + AVATAR_SIZE.x, VIRTUAL_SIZE.y - self.size.y - self.bottomMargin, 
    VIRTUAL_SIZE.x - self.leftMargin * 2 - AVATAR_SIZE.x, self.size.y, text, FONTS['retroville-s'])
  self.speakerTabBorderColor = self.textbox.panel.borderColor
  self.speakerTabBodyColor = self.textbox.panel.bodyColor  
  self.callback = callback or function() end
  self.destroying = false
  
  self.running = false
end

function StateDialogue:update(dt)
  self.running = true
  self.textbox:update(dt)
  self.avatar:update(dt)
  
  -- fade out dialogue elements as soon as the textbox closes
  if self.textbox:isClosed() and not self.destroying then
    self.avatarAnimationTimer:remove()
    local avatarFadeOutDuration = 0.3
    local sprite = self.avatar.components['Sprite']
    sprite:SetDrawable(TEXTURES[self.speaker], QUADS[self.speaker][1])
    
    self.destroying = true
    Timer.tween(avatarFadeOutDuration, {
      [sprite.color] = { 1, 1, 1, 0 },
      [self.textbox.triangleColor] = { 1, 1, 1, 0 },
      [self.textbox.panel.borderColor] = { 0, 0, 0, 0 },
      [self.textbox.panel.bodyColor] = { 0, 0, 0, 0 }
    })
    :finish(function()
      self.callback()
      gameManager:Pop()
    end)
  end
end

function StateDialogue:render()
  if self.running then
    self.textbox:render()
    self.avatar:render()
    
    -- draw tab with the name of the speaker
    love.graphics.setColor(self.textbox.panel.borderColor)
    love.graphics.rectangle('fill', self.textbox.x + 30, self.textbox.y - 20, 100, 22, 3)
    love.graphics.setColor(self.textbox.panel.borderColor)
    love.graphics.rectangle('fill', self.textbox.x + 30 + 2, self.textbox.y - 20 + 2, 100 - 4, 22, 3)
    
    if not self.textbox.closed then  
      love.graphics.setFont(FONTS['retroville-s'])
      love.graphics.setColor(0.4, 0.3, 0.2, 1)
      love.graphics.print(self.speaker, self.textbox.x + 30 + 2 + 10, self.textbox.y - 20 + 2 + 3)
    end
    
    love.graphics.setColor(1, 1, 1, 1)
  end
end

function StateDialogue:CreateAvatar()
  local avatar = tiny.Entity(self.leftMargin + AVATAR_SIZE.x / 2, VIRTUAL_SIZE.y - self.size.y - self.bottomMargin - 10 + AVATAR_SIZE.y / 2)
  
  local sprite = tiny.Sprite(TEXTURES[self.speaker], QUADS[self.speaker][1])
  avatar:AddComponent(sprite)
  
  return avatar
end