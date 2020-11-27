StateDialogue = Class{__includes = tiny.State}

function StateDialogue:init(speaker, text, callback)
  self.size = tiny.Vector2D(0.7 * VIRTUAL_SIZE.x, 0.2 * VIRTUAL_SIZE.y):Floor()
  self.leftMargin = math.floor((VIRTUAL_SIZE.x - self.size.x) / 2)
  self.bottomMargin = VIRTUAL_SIZE.y * 0.1

  self.speaker = speaker
  self.avatarTextureId = self.speaker == 'Alpha 12' and 'boss-101' or 'player-001'
  self.avatar = self:CreateAvatar()
  self.avatarTimer = 0.3
  self.avatarVariation = math.random(2)
  self.avatarFrameId = 1

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

  -- select next frame and animate avatars, depending on the speaker
  self.avatarTimer = self.avatarTimer - dt
  if self.avatarTimer < 0 then
    -- randomize frame interval
    self.avatarTimer = math.random(10, 20) / 100
    
    if self.speaker == 'Alpha 12' then
      if self.avatarFrameId == 1 or self.avatarFrameId == 5 then
        -- 20% chance to stay with mouth closed
        if math.random(10) < 9 then
          self.avatarFrameId = math.random(10) < 9 and 2 or 3
        end
      elseif self.avatarFrameId == 2 or self.avatarFrameId == 4 then
        self.avatarFrameId = math.random(10) < 9 and 1 or 3
      elseif self.avatarFrameId == 3 then
        self.avatarFrameId = math.random(10) < 5 and 1 or 2
      end    
      -- 10% chance of changing facial expression
      if self.avatarFrameId == 1 then
        self.avatarFrameId = math.random(10) < 10 and 1 or 5
      elseif self.avatarFrameId == 2 then
        self.avatarFrameId = math.random(10) < 10 and 2 or 4
      end
    elseif self.speaker == 'SR Comet' then
      if self.avatarFrameId == 1 or self.avatarFrameId == 2 or self.avatarFrameId == 3 then
        -- 20% chance to stay with mouth closed
        if math.random(10) < 9 then
          self.avatarFrameId = math.random(10) < 9 and 4 or 7
        end
      elseif self.avatarFrameId == 4 or self.avatarFrameId == 5 or self.avatarFrameId == 6 then
        self.avatarFrameId = math.random(10) < 9 and 1 or 7
      elseif self.avatarFrameId == 7 or self.avatarFrameId == 8 or self.avatarFrameId == 9 then
        self.avatarFrameId = math.random(10) < 5 and 1 or 4
      end
      -- apply variation
      self.avatarFrameId = self.avatarFrameId + self.avatarVariation - 1
      -- 10% chance of closing eyes
      if math.random(10) == 10 then
        self.avatarFrameId = self.avatarFrameId + 3 - self.avatarVariation
      end
    end
    
    local sprite = self.avatar.components['Sprite']
    sprite:SetDrawable(TEXTURES[self.avatarTextureId], QUADS[self.avatarTextureId][self.avatarFrameId])
  end
  
  -- fade out dialogue elements as soon as the textbox closes
  if self.textbox:isClosed() and not self.destroying then
    local avatarFadeOutDuration = 0.3
    local sprite = self.avatar.components['Sprite']
    sprite:SetDrawable(TEXTURES[self.avatarTextureId], QUADS[self.avatarTextureId][1])
    
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
  
  local sprite = tiny.Sprite(TEXTURES[self.avatarTextureId], QUADS[self.avatarTextureId][1])
  avatar:AddComponent(sprite)
  
  return avatar
end