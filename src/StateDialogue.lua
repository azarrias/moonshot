StateDialogue = Class{__includes = tiny.State}

function StateDialogue:init(text, callback)
  self.size = tiny.Vector2D(0.7 * VIRTUAL_SIZE.x, 0.2 * VIRTUAL_SIZE.y):Floor()
  self.leftMargin = math.floor((VIRTUAL_SIZE.x - self.size.x) / 2)
  self.bottomMargin = VIRTUAL_SIZE.y * 0.1
  self.avatar = TEXTURES['boss']
  self.textbox = Textbox(self.leftMargin + self.avatar:getWidth(), VIRTUAL_SIZE.y - self.size.y - self.bottomMargin, 
    VIRTUAL_SIZE.x - self.leftMargin * 2 - self.avatar:getWidth(), self.size.y, text, FONTS['retroville-s'])
  self.callback = callback or function() end
end

function StateDialogue:update(dt)
  self.textbox:update(dt)
  
  if self.textbox:isClosed() then
    self.callback()
    gameManager:Pop()
  end
end

function StateDialogue:render()
  self.textbox:render()
  love.graphics.draw(self.avatar, self.leftMargin, VIRTUAL_SIZE.y - self.size.y - self.bottomMargin - 10)
end