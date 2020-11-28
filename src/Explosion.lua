Explosion = Class{}

function Explosion:init(position, size)
  self.image = self:CreateShape(size)
  
  self.bufferNum = 30
  self.numParticles = 15
  self.pSysMinLifetime = 0.6
  self.pSysMaxLifetime = 0.8
  self.pSysMinLinearAcceleration = tiny.Vector2D(-100, -100)
  self.pSysMaxLinearAcceleration = tiny.Vector2D(100, 100)
  
  self.particleSystem = love.graphics.newParticleSystem(self.image, self.bufferNum)
  self.particleSystem:setParticleLifetime(self.pSysMinLifetime, self.pSysMaxLifetime)
  self.particleSystem:setLinearAcceleration(self.pSysMinLinearAcceleration.x, self.pSysMinLinearAcceleration.y,
    self.pSysMaxLinearAcceleration.x, self.pSysMaxLinearAcceleration.y)
  self.particleSystem:setColors(1, 1, 0, 
                                1, 1, 153 / 255, 
                                51 / 255, 1, 64 / 255, 
                                64 / 255, 64 / 255, 0)
  self.particleSystem:setSizes(0.5, 0.5)
  self.particleSystem:setPosition(position.x, position.y)
  self.particleSystem:emit(self.numParticles)
end

function Explosion:update(dt)
  self.particleSystem:update(dt)
end

function Explosion:render()
  love.graphics.draw(self.particleSystem)
end

function Explosion:CreateShape(size)
  local canvas = love.graphics.newCanvas(size, size)
  love.graphics.setCanvas(canvas)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.circle("fill", size / 2, size / 2, size / 2)
  love.graphics.setCanvas()
  return canvas
end
