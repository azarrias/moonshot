Level = Class{}

function Level:init(levelNum)
  self.num = levelNum
  
  self.bgSky = SkyLayer(20)
  self.mgSky = SkyLayer(25)
  self.fgSky = SkyLayer(30)
end

function Level:update(dt)
  self.bgSky:update(dt)
  self.mgSky:update(dt)
  self.fgSky:update(dt)
end

function Level:render()
  self.bgSky:render()
  self.mgSky:render()
  self.fgSky:render()
end