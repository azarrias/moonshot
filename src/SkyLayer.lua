SkyLayer = Class{}

function SkyLayer:init(speed)
  -- create image data from point on canvas
  local canvas = love.graphics.newCanvas(7, 1)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.setColor(248 / 255, 247 / 255, 255 / 255) -- white #f8f7ff
  love.graphics.points(1, 1)
  love.graphics.setColor(255 / 255, 244 / 255, 234 / 255) -- white #fff4ea
  love.graphics.points(2, 1)
  love.graphics.setColor(255 / 255, 210 / 255, 161 / 255) -- orange #ffd2a1
  love.graphics.points(3, 1)
  love.graphics.setColor(255 / 255, 204 / 255, 111 / 255) -- amber #ffcc6f
  love.graphics.points(4, 1)
  love.graphics.setColor(155 / 255, 176 / 255, 255 / 255) -- blue #9bb0ff
  love.graphics.points(5, 1)
  love.graphics.setColor(170 / 255, 191 / 255, 255 / 255) -- light blue #aabfff
  love.graphics.points(6, 1)
  love.graphics.setColor(202 / 255, 215 / 255, 255 / 255) -- lighter blue #cad7ff
  love.graphics.points(7, 1)
  love.graphics.setCanvas()
  self.starImage = love.graphics.newImage(canvas:newImageData())
  self.starQuads = GenerateQuads(self.starImage, 1, 7, tiny.Vector2D(1, 1))
  
  self.spriteBatch = love.graphics.newSpriteBatch(self.starImage)
  self.startX = 1
  
  self.max_num_stars_per_screen = 25

  self:ExtendSpriteBatch(self.max_num_stars_per_screen)
  self:ExtendSpriteBatch(self.max_num_stars_per_screen)
  
  self.cameraOffsetX = 0
  self.cameraSpeedX = speed
end

function SkyLayer:CreateRandomStar()
  star = {
    quad = self.starQuads[math.random(#self.starQuads)],
    posX = math.random(self.startX, self.startX + VIRTUAL_SIZE.x),
    posY = math.random(VIRTUAL_SIZE.y),
    rot = 0,
    sca = math.random(2)
  }
  return star
end

function SkyLayer:ExtendSpriteBatch()
  for i = 1, self.max_num_stars_per_screen do
    local star = self:CreateRandomStar()
    self.spriteBatch:add(star.quad, star.posX, star.posY, star.rot, star.sca, star.sca)
  end
  self.startX = self.startX + VIRTUAL_SIZE.x
end

function SkyLayer:UpdateSpriteBatch()
  local id = (self.startX - 1) / VIRTUAL_SIZE.x % 2
  for i = id * self.max_num_stars_per_screen + 1, id * self.max_num_stars_per_screen + self.max_num_stars_per_screen do
    local star = self:CreateRandomStar()
    self.spriteBatch:set(i, star.quad, star.posX, star.posY, star.rot, star.sca, star.sca)
  end
  self.spriteBatch:flush()
  self.startX = self.startX + VIRTUAL_SIZE.x
end

function SkyLayer:update(dt)
  self.cameraOffsetX = self.cameraOffsetX + self.cameraSpeedX * dt
  if self.cameraOffsetX >= self.startX - VIRTUAL_SIZE.x then
    self:UpdateSpriteBatch()
  end
end

function SkyLayer:render()
  love.graphics.push()
  love.graphics.translate(math.floor(-self.cameraOffsetX + 0.5), 0)
  love.graphics.draw(self.spriteBatch)
  love.graphics.pop()
end