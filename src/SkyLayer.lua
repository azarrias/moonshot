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
  
  self.stars = {}
  self.spriteBatch = love.graphics.newSpriteBatch(self.starImage)
  for i = 1, 100 do
    self:AddStar(math.random(VIRTUAL_SIZE.x * 2), math.random(VIRTUAL_SIZE.y))
  end
  self:UpdateSpriteBatch()
end

function SkyLayer:AddStar(x, y)
  table.insert(self.stars, { x = x, y = y })
end

function SkyLayer:UpdateSpriteBatch()
  self.spriteBatch:clear()
  for k, star in ipairs(self.stars) do
    self.spriteBatch:add(star.x, star.y)
  end
  self.spriteBatch:flush()
end

function SkyLayer:update(dt)
end

function SkyLayer:render()
  love.graphics.draw(self.spriteBatch)
end