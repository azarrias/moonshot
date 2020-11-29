HUD = Class{}

function HUD:init(playerController, level, points, pods)
  self.playerController = playerController
  self.level = level
  self.points = points
  self.hp = self.playerController.hp
  self.maxhp = 5
  self.pods = pods
  
  -- health icon
  self.border = 2
  self.health_icon_height = LEVEL_OFFSET.y / 2
  local health_icon_offset = tiny.Vector2D(LEVEL_OFFSET.y / 3, 0)
  self.health_icon_pos = tiny.Vector2D(LEVEL_OFFSET.y / 2 - self.health_icon_height / 2 + health_icon_offset.x, LEVEL_OFFSET.y / 2 - self.health_icon_height / 2 + health_icon_offset.y):Floor()
  self.health_icon_thickness = self.health_icon_height / 3
  
  -- health bar
  local hp_bars_offset = tiny.Vector2D(4, 2)
  self.hp_bars_pos = self.health_icon_pos + tiny.Vector2D(self.health_icon_height, 0) + hp_bars_offset
  self.hp_bars_size = tiny.Vector2D(math.floor(self.health_icon_thickness * 0.5), self.health_icon_height - hp_bars_offset.y)
  self.hp_bars_gap_x = 4
end

function HUD:update(dt)

end

function HUD:render()
  -- health cross
  love.graphics.setColor(198 / 255, 42 / 255, 136 / 255)
  love.graphics.rectangle('fill', -- vertical bar
    math.floor(self.health_icon_pos.x + self.health_icon_height / 2 - self.health_icon_thickness / 2), 
    self.health_icon_pos.y, 
    self.health_icon_thickness, 
    self.health_icon_height) 
  love.graphics.rectangle('fill', -- horizontal bar
    self.health_icon_pos.x, 
    math.floor(self.health_icon_pos.y + self.health_icon_height / 2 - self.health_icon_thickness / 2), 
    self.health_icon_height, 
    self.health_icon_thickness)

  -- hp bars
  love.graphics.setLineWidth(self.border)
  for i = 1, self.maxhp, 1 do
    if self.hp >= i then
      love.graphics.rectangle('line', 
        self.hp_bars_pos.x + self.hp_bars_size.x * (i - 1) + self.hp_bars_gap_x * (i - 1), 
        self.hp_bars_pos.y, 
        self.hp_bars_size.x, 
        self.hp_bars_size.y)
      love.graphics.rectangle('fill', 
        self.hp_bars_pos.x + self.hp_bars_size.x * (i - 1) + self.hp_bars_gap_x * (i - 1), 
        self.hp_bars_pos.y, 
        self.hp_bars_size.x, 
        self.hp_bars_size.y)
    end
  end
  
  --love.graphics.setColor(0.5, 0.1, 0.5)
  love.graphics.setFont(FONTS['retroville-s'])
  love.graphics.printf(self.points .. " x ", 0, 1, VIRTUAL_SIZE.x - 21, 'right')
  if self.pods then
    love.graphics.printf(self.pods .. " x ", 0, 11, VIRTUAL_SIZE.x - 21, 'right')
  end
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(TEXTURES['enemy_1'], QUADS['enemy_1-moving'][1], VIRTUAL_SIZE.x - 20, 0, 0, 0.5, 0.5)
  
  if self.pods then
    love.graphics.draw(TEXTURES['pod'], VIRTUAL_SIZE.x - 18, 14, 0, 0.2, 0.2)
  end
end
