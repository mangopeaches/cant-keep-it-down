-- main driver file
-- @author Thomas Breese

-- initial load function, called once on start
function love.load()
  -- load required resources
  require 'require'
  
  -- create levels for the game
  levels = {}
  table.insert(levels, TimedLevel('level one', 1.5, 2, 100, 300, 100, 1, 1, 5))
  table.insert(levels, TimedLevel('level two', .5, 2, 200, 400, 50, 1, 1, 20))
  table.insert(levels, TimedLevel('level three', .5, 2, 100, 300, 100, 1, 1, 30))
  play = Play(Player(), levels)
end

-- update function, called continuously
function love.update(dt)
  play:update(dt)
end

-- draw function, puts items onto the screen
function love.draw()
  play:draw()
end