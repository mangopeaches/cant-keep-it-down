-- level where a certain score condition needs to be met to pass
-- @author Thomas Breese

ScoreLevel = Level:extend()

-- create a new instance
function ScoreLevel:new(name, release_interval, enemy_interval,
  player_speed, projectile_speed, enemy_speed, point_value, point_multiplier, target_score)
  ScoreLevel.super.new(self, name, release_interval, enemy_interval, player_speed,
  projectile_speed, enemy_speed, point_value, point_multiplier)
  self.target_score = target_score
end

-- return whether or not the level is completed
function ScoreLevel:completed(current_score)
  return current_score >= self.target_score
end

return ScoreLevel