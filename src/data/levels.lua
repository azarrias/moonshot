-- data for game levels
LEVELS = {
  [1] = {
    dialogue = { [1] = { speaker = "Alpha 12", message = "SR Comet, this is Alpha one-two from the MCC ... radio check." },
                 [2] = { speaker = "SR Comet", message = "Read you loud and clear, chief! Go ahead..." },
                 [3] = { speaker = "Alpha 12", message = "A few enemies have been spotted from the ISS.\nThey are approaching the Earth's atmosphere.\nThey are few and shouldn't pose a threat, but you must neutralize them at all costs before they become an issue." },
                 [4] = { speaker = "SR Comet", message = "Wilco, out." } 
               },
    finalXPos = 1000,
    enemies = { { type_id = 1, position = tiny.Vector2D(1300, VIRTUAL_SIZE.y / 2) },
                { type_id = 1, position = tiny.Vector2D(1300 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 2) },
              }
  },
  [2] = {
    dialogue = "Hi! this is only a test.\nSo, does everything display properly?\nIf pagination works, I will sleep better tonight.\nOtherwise, it will be a problem.\nBut again, everything can be solved.",
    finalXPos = 600,
    enemies = { { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(1100, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(1150, VIRTUAL_SIZE.y * 0.33) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(1200, VIRTUAL_SIZE.y * 0.66) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(1400, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(1400 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(1400 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(1600, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(1650, VIRTUAL_SIZE.y * 0.33) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(1700, VIRTUAL_SIZE.y * 0.66) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(1900, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(1900 + ENEMY_TYPE_2_SIZE.x + 4, VIRTUAL_SIZE.y * 0.5) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(1900 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), VIRTUAL_SIZE.y * 0.5) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(2200, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + ENEMY_TYPE_1_SIZE.x + 4, VIRTUAL_SIZE.y / 3) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + 2 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + 3 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 1, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + 4 * (ENEMY_TYPE_1_SIZE.x + 4), VIRTUAL_SIZE.y / 3) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(2200, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + ENEMY_TYPE_2_SIZE.x + 4, 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + 2 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
                { type_id = 2, movement = 'straight-diagonal', position = tiny.Vector2D(2200 + 3 * (ENEMY_TYPE_2_SIZE.x + 4), 2 * VIRTUAL_SIZE.y / 3) },
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