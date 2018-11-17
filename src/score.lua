-- keeps track of the players score
-- @author Thomas Breese

Score = Object:extend()

-- create a new instance
function Score:new()
  self.score = 0
  self.point_value = 1
  self.multiplier = 1
  self.allow_negative = false
end

-- increases the score
function Score:increment()
  self.score = self.score + self.point_value * self.multiplier
end

-- decreases the score
function Score:decrement()
  self.score = self.score - self.point_value * self.multiplier
end

-- increases the score by a provided one-time multiplier
function Score:incrementWithMultiplier(multiplier)
  self.score = self.score + self.point_value * multiplier
end

-- decrease the score by a provided one-time multiplier
function Score:decreaseWithMultiplier(multiplier)
  self.score = self.score - self.point_value * multiplier
end

-- sets point value amount for the current score keeping
function Score:setPointValue(point_value)
  self.point_value = point_value
end

-- accessor for current point value
function Score:getPointValue()
  return self.point_value
end

-- mutator for the multiplier
function Score:setMultiplier(multiplier)
  self.multiplier = multiplier
end

-- accessor for the score
function Score:getScore()
  return self.score
end

-- accessor for the multiplier
function Score:getMultiplier()
  return self.multiplier
end

-- sets whether or not negative values are allowed
function Score:setAllowNegative(value)
  self.allow_negative = value
end

-- returns whether or not we're allowing negatives
function Score:getAllowNegative()
  return self.allow_negative
end

return Score