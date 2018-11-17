-- mixins for objects that can grow in scale
-- @author Thomas Breese

Scaleable = Object:extend()

-- accessor for width
function Scaleable:getWidth()
  return self.width
end

-- mutator for width
function Scaleable:setWidth(width)
  self.width = width
end

-- accessor for height
function Scaleable:getHeight()
  return self.height
end

-- mutator for height
function Scaleable:setHeight(height)
  self.height = height
end

-- scales height and width by a given multiplier
function Scaleable:scale(multiplier)
  self:scaleHeight(multiplier)
  self:scaleWidth(multiplier)
end

function Scaleable:scaleHeight(multiplier)
  self.height = self.height * multiplier
end

function Scaleable:scaleWidth(multiplier)
  self.width = self.width * multiplier
end

return Scaleable