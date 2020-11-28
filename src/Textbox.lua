Textbox = Class{}

local leftMargin, upMargin

function Textbox:init(x, y, width, height, text, font)
  leftMargin = 12
  upMargin = 14
  self.panel = Panel(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  
  self.text = text
  self.font = font or FONTS['small']
  _, self.textChunks = self.font:getWrap(self.text, self.width - 2.6 * leftMargin)
  
  self.chunkCounter = 1
  self.endOfText = false
  self.closed = false
  
  self.drawTriangleOutline = true
  Timer.every(0.5, function()
    self.drawTriangleOutline = not self.drawTriangleOutline
  end)
  self.triangleColor = { 1, 1, 1, 1 }
  
  self:next()
end

-- go to next page of text (if any), otherwise toggles the textbox
function Textbox:nextChunks()
  local chunks = {}
  local fontHeight = self.font:getHeight()
  local consumedHeight = 0
  
  while consumedHeight < self.height - 2 * upMargin - self.font:getHeight() do
    table.insert(chunks, self.textChunks[self.chunkCounter])
    consumedHeight = consumedHeight + fontHeight
    if self.chunkCounter == #self.textChunks then
      self.endOfText = true
      return chunks
    end
    self.chunkCounter = self.chunkCounter + 1
  end

  return chunks
end

function Textbox:next()
  if self.endOfText then
    self.displayingChunks = {}
    --self.panel:toggle()
    self.closed = true
  else
    self.displayingChunks = self:nextChunks()
  end
end

function Textbox:update(dt)
  if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] 
    or love.keyboard.keysPressed['space'] or love.mouse.buttonReleased[1] then
      SOUNDS['skip']:play()
      self:next()
  end
end

function Textbox:isClosed()
  return self.closed
end

function Textbox:render()
  self.panel:render()
  
  love.graphics.setFont(self.font)
  for i = 1, #self.displayingChunks do
    love.graphics.print(self.displayingChunks[i], self.x + leftMargin, self.y + upMargin + (i - 1) * self.font:getHeight())
  end
  
  -- render triangle to indicate required key press to advance to the next text box
  if self.canInput then
    love.graphics.setColor(self.triangleColor)
    love.graphics.setLineWidth(1.5)
    if self.drawTriangleOutline then
      love.graphics.polygon('line', math.floor(self.x + self.width - 2 * leftMargin), math.floor(self.y + self.height - 0.5 * upMargin), 
        math.floor(self.x + self.width - 1 * leftMargin), math.floor(self.y + self.height - 0.5 * upMargin),
        math.floor(self.x + self.width - 1.5 * leftMargin), math.floor(self.y + self.height + 0.5 * upMargin))
    end
    love.graphics.polygon('fill', math.floor(self.x + self.width - 2 * leftMargin), math.floor(self.y + self.height - 0.5 * upMargin), 
      math.floor(self.x + self.width - 1 * leftMargin), math.floor(self.y + self.height - 0.5 * upMargin),
      math.floor(self.x + self.width - 1.5 * leftMargin), math.floor(self.y + self.height + 0.5 * upMargin))
  end
end
