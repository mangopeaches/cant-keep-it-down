-- level where a certain time has to have expired to complete the level
-- @author Thomas Breese

TimedLevel = Level:extend()

-- create a new instance
function TimedLevel:new(name, release_interval, enemy_interval, 
  player_speed, projectile_speed, enemy_speed, point_value, point_multiplier, duration)
  TimedLevel.super.new(self, name, release_interval, enemy_interval, player_speed,
  projectile_speed, enemy_speed, point_value, point_multiplier)
  self.duration = duration
end

-- return whether or not the level is completed
function TimedLevel:completed(current_time)
  return self.start_time + self.duration <= current_time
end

return TimedLevel