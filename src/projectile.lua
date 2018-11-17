-- represents a projectile out of the player
-- @author Thomas Breese

Projectile = Object:extend()
-- attach moveable behaviors
Projectile:implement(Moveable)
Projectile:implement(Scaleable)

-- constants for direction
Projectile.up = 0
Projectile.right = 1
Projectile.down = 2
Projectile.left = 3

-- creates a player relative to the origin of an object
Projectile.createRelativeTo = function(object)
  local x = object:getX()
  local y = object:getY()
  local width = object:getWidth()
  local height = object:getHeight()
  local dir = math.random(0,3)
  
  -- determine start points based on direction our of the object
  if dir == Projectile.up then
    -- up
    y = y - 11
    -- center at top of player, x plus half width of player plus half width of proj
    x = x + width / 2 - 4
  elseif dir == Projectile.right then
    -- right
    x = x + width + 2
    -- center at right of player
    y = y + width / 2 - 4
  elseif dir == Projectile.down then
    -- down
    y = y + height + 2
    -- center at bottom of player
    x = x + width / 2 - 4
  elseif dir == Projectile.left then
    -- left
    x = x - 11
    -- center
    y = y + width / 2 - 4
  end
  return Projectile(x, y, dir)
end

-- constructor for a new projectile
function Projectile:new(x, y, direction)
  self.x = x
  self.y = y
  self.height = 10
  self.width = 10
  self.direction = direction
  self.looped = false
  self.killed = false
  -- static, speed not increasing for now
  self.speed = 300
  self.speed_max = 300
  self.speed_min = 300
  self.speed_multiplier = 1.5
end

-- update function, continues movement in a given direction
-- once it loops the screen once it's killed after going off the screen again
function Projectile:update(dt)
  local x = self.x
  local y = self.y
  local looped = self.looped
  local killed = self.killed
  
  local window_height = love.graphics.getHeight()
  local window_width = love.graphics.getWidth()
  
  if self.direction == Projectile.up then
    y = y - self.speed * dt
    if y < 0 then
      if looped then
        killed = true
      else
        looped = true
        y = window_height - self.height
      end
    end
  elseif self.direction == Projectile.down then
    y = y + self.speed * dt
    if y > window_height then
      if looped then
        killed = true
      else
        looped = true
        y = 0
      end
    end
  elseif self.direction == Projectile.left then
    x = x - self.speed * dt
    if x < 0 then
      if looped then
        killed = true
      else
        looped = true
        x = window_width - self.width
      end
    end
  elseif self.direction == Projectile.right then
    x = x + self.speed * dt
    if x > window_width then
      if looped then
        killed = true
      else
        looped = true
        x = 0
      end
    end
  end
  
  -- update the projectile
  self.x = x
  self.y = y
  self.killed = killed
  self.looped = looped
end

-- accessor for killed property
function Projectile:getKilled()
  return self.killed
end

-- draws the projectile at a given location
function Projectile:draw()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Projectile