-- data for game levels
LEVELS = {
  [1] = {
    dialogue = "Hi! this is only a test.\nSo, does everything display properly?\nIf pagination works, I will sleep better tonight.\nOtherwise, it will be a problem.\nBut again, everything can be solved.",
    finalXPos = 600,
    enemies = { { type_id = 1, position = tiny.Vector2D(1100, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(1150, VIRTUAL_SIZE.y * 0.33) },
                { type_id = 1, position = tiny.Vector2D(1200, VIRTUAL_SIZE.y * 0.66) },
                { type_id = 1, position = tiny.Vector2D(1400, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(1400 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(1400 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1600, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1650, VIRTUAL_SIZE.y * 0.33) },
                { type_id = 2, position = tiny.Vector2D(1700, VIRTUAL_SIZE.y * 0.66) },
                { type_id = 2, position = tiny.Vector2D(1900, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1900 + ENEMY_TYPE_2_SIZE.x + 4, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1900 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(2200, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(2200 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(2200 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(2200 + 3 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(2200 + 4 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(2200, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(2200 + ENEMY_TYPE_2_SIZE.x + 4, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(2200 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(2200 + 3 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
              }
  },
  [2] = {
    finalXPos = 500,
    enemies = { { type_id = 1, position = tiny.Vector2D(1000, VIRTUAL_SIZE.y / 2) },
                { type_id = 1, position = tiny.Vector2D(1000 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 2) },
              }
  },
--[[  [3] = {
    hasBoss = false,
    finalXPos = 300
  },
  [4] = {
    hasBoss = true,
    finalXPos = 300
  },
  ]]
}