SkyLayer = Class{}

function SkyLayer:init()
  -- create image data from point on canvas
  local canvas = love.graphics.newCanvas(1, 1)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.setColor(1, 1, 1)
  love.graphics.points(1, 1)
  love.graphics.setCanvas()
  self.starImage = love.graphics.newImage(canvas:newImageData())
  
  self.spriteBatch = love.graphics.newSpriteBatch(self.starImage)
  self.startX = 1

  self:ExtendSpriteBatch(self.startX)
  self:ExtendSpriteBatch(self.startX)
  
  self.cameraOffsetX = 0
  self.cameraSpeedX = 15
end

function SkyLayer:AddStar(x, y)
  table.insert(self.stars, { x = x, y = y })
end

function SkyLayer:ExtendSpriteBatch(startX)
  for i = 1, 25 do
    self.spriteBatch:add(math.random(startX, startX + VIRTUAL_SIZE.x), math.random(VIRTUAL_SIZE.y))
  end
  self.startX = self.startX + VIRTUAL_SIZE.x
end

function SkyLayer:UpdateSpriteBatch(startX)
  local id = (startX - 1) / VIRTUAL_SIZE.x % 2
  for i = id * 25 + 1, id * 25 + 25 do
    self.spriteBatch:set(i, math.random(startX, startX + VIRTUAL_SIZE.x), math.random(VIRTUAL_SIZE.y))
  end
  self.spriteBatch:flush()
  self.startX = self.startX + VIRTUAL_SIZE.x
end

function SkyLayer:update(dt)
  self.cameraOffsetX = self.cameraOffsetX + self.cameraSpeedX * dt
  if self.cameraOffsetX >= self.startX - VIRTUAL_SIZE.x then
    self:UpdateSpriteBatch(self.startX)
  end
end

function SkyLayer:render()
  love.graphics.push()
  love.graphics.translate(math.floor(-self.cameraOffsetX + 0.5), 0)
  love.graphics.draw(self.spriteBatch)
  love.graphics.pop()
end