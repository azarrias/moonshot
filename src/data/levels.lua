-- data for game levels
LEVELS = {
  [1] = {
    hasBoss = false,
    finalXPos = 2000,
    enemies = { { type_id = 1, position = tiny.Vector2D(700, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(750, VIRTUAL_SIZE.y * 0.33) },
                { type_id = 1, position = tiny.Vector2D(800, VIRTUAL_SIZE.y * 0.66) },
                { type_id = 1, position = tiny.Vector2D(1000, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(1000 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(1000 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1200, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1250, VIRTUAL_SIZE.y * 0.33) },
                { type_id = 2, position = tiny.Vector2D(1300, VIRTUAL_SIZE.y * 0.66) },
                { type_id = 2, position = tiny.Vector2D(1500, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1500 + ENEMY_TYPE_2_SIZE.x + 4, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, position = tiny.Vector2D(1500 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, position = tiny.Vector2D(1800, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(1800 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(1800 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(1800 + 3 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(1800 + 4 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(1800, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(1800 + ENEMY_TYPE_2_SIZE.x + 4, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(1800 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(1800 + 3 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
              }
  },
  [2] = {
    hasBoss = false,
    finalXPos = 500,
    enemies = { { type_id = 1, position = tiny.Vector2D(300, VIRTUAL_SIZE.y / 2) },
                { type_id = 1, position = tiny.Vector2D(300 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 2) },
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