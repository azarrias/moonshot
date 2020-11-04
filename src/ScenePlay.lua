ScenePlay = Class{__includes=tiny.Scene}

function ScenePlay:init()
  self.player_pos = tiny.Vector2D(math.floor(VIRTUAL_SIZE.x / 2), math.floor(VIRTUAL_SIZE.y / 2))
end

function ScenePlay:render()
  love.graphics.draw(TEXTURES['player'], QUADS['player'][2], self.player_pos.x, self.player_pos.y)
end