-- Represents an enemy
-- @author Thomas Breese

Enemy = Object:extend()
-- attach moveable behaviors
Enemy:implement(Moveable)
Enemy:implement(Scaleable)
-- attach lifetime behaviors
Enemy:implement(Lifetime)

function Enemy:new(x, y, following_moveable)
  self.x = x
  self.y = y
  self.width = 10
  self.height = 10
  -- keep reference to object the enemy is following
  self.following = following_moveable
  
  -- enemies can increase/decrease speed
  self.speed = 100
  self.speed_max = 500
  self.speed_min = 100
  self.speed_multiplier = 1.1 -- 10% multiplier
  
  -- lifetime params
  self.lifetime = 20 -- lives for 20 seconds
  self.life_start = love.timer.getTime()
end

-- enemy movement
-- right now it's following the player
function Enemy:update(dt)
  local obj_x = self.following:getX()
  local obj_y = self.following:getY()
  local angle = math.atan2(obj_y - self.y, obj_x - self.x)
  local cos = math.cos(angle)
  local sin = math.sin(angle)
  
  self.x = self.x + self.speed * cos * dt
  self.y = self.y + self.speed * sin * dt
end

-- draw the enemy
function Enemy:draw()
  love.graphics.rectangle('line', self.x, self.y, self.height, self.width)
end

return Enemy