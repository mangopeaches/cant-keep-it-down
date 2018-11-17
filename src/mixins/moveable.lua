-- mixins for all moveable objects
-- @author Thomas Breese

Moveable = Object:extend()

function Moveable:getX()
  return self.x
end

function Moveable:setX(x)
  self.x = x
end

function Moveable:getY()
  return self.y
end

function Moveable:setY(y)
  self.y = y
end

function Moveable:getSpeed()
  return self.speed
end

function Moveable:setSpeed(speed)
  self.speed = speed
end

function Moveable:getSpeedMultiplier()
  return self.speed_multiplier
end

function Moveable:setSpeedMultiplier(multiplier)
  self.speed_multiplier = multiplier
end

function Moveable:getSpeedMax()
  return self.speed_max
end

function Moveable:setSpeedMax(max)
  self.speed_max = max
end

function Moveable:getSpeedMin()
  return self.speed_min
end

function Moveable:setSpeedMin(min)
  self.speed_min = min
end

function Moveable:increaseSpeed()
  local new_speed = self.speed + self.speed * self.speed_multiplier
  if new_speed > self.speed_max then
    new_speed = self.speed_max
  end
  self.speed = new_speed
end

function Moveable:decreaseSpeed()
  local new_speed = self.speed - self.speed * self.speed_multiplier
  if new_speed < self.speed_min then
    new_speed = self.speed_min
  end
  self.speed = new_speed
end

return Moveable