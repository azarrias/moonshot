-- data for game levels
LEVELS = {
  [1] = {
    hasBoss = false,
    finalXPos = 1000,
    enemies = { { type_id = 1, position = tiny.Vector2D(500, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(500 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(500 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(500 + 3 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, position = tiny.Vector2D(500 + 4 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(500, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(500 + ENEMY_TYPE_2_SIZE.x + 4, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(500 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, position = tiny.Vector2D(500 + 3 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
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