-- handles collision detection
-- @author Thomas Breese

-- checks if two objects are colliding
-- @return Bool
function checkCollision(obj_1, obj_2)
  local obj_1_left = obj_1:getX()
  local obj_1_right = obj_1:getX() + obj_1:getWidth()
  local obj_1_top = obj_1:getY()
  local obj_1_bottom = obj_1:getY() + obj_1:getHeight()
  
  local obj_2_left = obj_2:getX()
  local obj_2_right = obj_2:getX() + obj_2:getWidth()
  local obj_2_top = obj_2:getY()
  local obj_2_bottom = obj_2:getY() + obj_2:getHeight()
  
  if obj_1_right > obj_2_left and
  obj_1_left < obj_2_right and
  obj_1_bottom > obj_2_top and
  obj_1_top < obj_2_bottom then
    return true
  end
  
  return false
end