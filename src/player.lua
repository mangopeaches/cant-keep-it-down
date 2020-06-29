-- main Player class
-- @author Thomas Breese

Player = Object:extend()
-- attach moveable behaviors
Player:implement(Moveable)
Player:implement(Scaleable)

-- constructor for a new player
function Player:new()
  self.width = 30
  self.height = 30
  self.speed = 100
  self.speed_max = 1000
  self.speed_min = 100
  self.speed_multiplier = 1.1 -- 10% multiplier
  self.up_image = love.graphics.newImage('assets/up.jpg')
  self.down_image = love.graphics.newImage('assets/up.jpg')
  self.left_image = love.graphics.newImage('assets/right.jpg')
  self.right_image = love.graphics.newImage('assets/right.jpg')
  self.neutral_image = love.graphics.newImage('assets/sample.jpg')
  self.image = self.neutral_image -- start out neutral
  
  -- start in the center of the screen
  self.x = love.graphics.getWidth() / 2 - self.width / 2
  self.y = love.graphics.getHeight() / 2 - self.height / 2
end

-- update player
function Player:update(dt)
  local x = self.x
  local y = self.y
  local screen_width = love.graphics.getWidth()
  local screen_height = love.graphics.getHeight()
  
  -- movement in all directions
  if love.keyboard.isDown('right') then
    self.image = self.right_image
    x = x + self.speed * dt
  elseif love.keyboard.isDown('left') then
    self.image = self.left_image
    x = x - self.speed * dt
  elseif love.keyboard.isDown('up') then
    self.image = self.up_image
    y = y - self.speed * dt
  elseif love.keyboard.isDown('down') then
    self.image = self.down_image
    y = y + self.speed * dt
  end
  
  -- keep the player on the screen
  -- potentially allow for the player to loop the screen as well at a certain point
  if x < 0 then
    x = 0
  elseif x > screen_width - self.width then
    x = screen_width - self.width
  end
  
  if y < 0 then
    y = 0
  elseif y > screen_height - self.height then
    y = screen_height - self.height
  end
  
  self.x = x
  self.y = y
end

-- draw the player
function Player:draw()
  --love.graphics.newImage('../assets/person')
  love.graphics.draw(self.image, self.x, self.y)--, self.width, self.height)
  --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

return Player