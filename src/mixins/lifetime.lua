-- mixins for temporary objects which will have a given finite lifetime
-- @author Thomas Breese

Lifetime = Object:extend()

-- accessor for lifetime (seconds)
function Lifetime:getLifetime()
  return self.lifetime
end

-- mutator for lifetime member var
function Lifetime:setLifetime(lifetime)
  self.lifetime = lifetime
end

-- accessor for when a life started
function Lifetime:getLifeStart()
  return self.life_start
end

-- mutator for when a life starts
function Lifetime:setLifeStart(life_start)
  self.life_start = life_start
end

-- returns whether or not the object has lived it's lifetime
function Lifetime:hasLifeExpired(time)
  -- 0 for lifetime means it dones't expire
  if self.lifetime == 0 then
    return false
  else
    return time - self.life_start >= self.lifetime
  end
end

return Lifetime