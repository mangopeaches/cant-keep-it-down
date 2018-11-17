-- represents a given level
-- @author Thomas Breese

Level = Object:extend()

function Level:new(name, release_interval, enemy_interval, player_speed, projectile_speed, enemy_speed, point_value, point_multiplier)
  self.name = name
  -- keep track of when the level was started
  self.start_time = false
  self.end_time = false
  -- set the level to not started
  self.started = false
  -- keep track of whether or not the complete conditions have been met
  self.complete = false
  -- keep track of spawn counters and speeds
  self.release_interval = release_interval
  self.enemy_interval = enemy_interval
  self.player_speed = player_speed
  self.projectile_speed = projectile_speed
  self.enemy_speed = enemy_speed
  -- point values and multipliers
  self.point_value = point_value
  self.point_multiplier = point_multiplier
end

-- accessor for point value
function Level:getPointValue()
  return self.point_value
end

-- accessor for point multiplier
function Level:getPointMultiplier()
  return self.point_multiplier
end

-- accessor for release interval
function Level:getReleaseInterval()
  return self.release_interval
end

-- accessor for enemy spawn interval
function Level:getEnemyInterval()
  return self.enemy_interval
end

-- accessor for player speed
function Level:getPlayerSpeed()
  return self.player_speed
end

-- accessor for projectile speed
function Level:getProjectileSpeed()
  return self.projectile_speed
end

-- accessor for enemy speed
function Level:getEnemySpeed()
  return self.enemy_speed
end

-- return whether or not the level has been started
function Level:isStarted()
  return self.started
end

-- starts the level timer
function Level:start()
  self.started = true
  self.start_time = love.timer.getTime()
end

-- sets the completion time for the level
function Level:finish(completion_time)
  self.end_time = completion_time
end

-- return whether or not the level has been completed
function Level:completed()
  return self.completed
end

-- accessor for the name
function Level:getName()
  return self.name
end

-- mutator for the level name
function Level:setName(name)
  self.name = name
end

return Level