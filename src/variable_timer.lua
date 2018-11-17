-- timer which has variable intervals
-- @author Thomas Breese

VariableTimer = Timer:extend()

-- constructor
function VariableTimer:new(start_time, interval_low, interval_high)
  VariableTimer.super.new(self, start_time, interval_low)
  self.interval_high = interval_high
end

-- determines if timer is in it's next interval
-- meaning that is hasn't been triggered yet for the given period
function VariableTimer:isReady()
  local current_time = love.timer.getTime()
  local interval = math.random(self.interval, self.interval_high)
  
  if current_time - self.last_time >= interval then
    self.last_time = current_time
    return true
  end
  
  return false
end

-- increases the interval, making the timer less frequent
function VariableTimer:increaseInterval(multiplier)
  VariableTimer.super.increaseInterval(multiplier)
  self.interval_high = self.interval_high + self.interval_high * multiplier
end

-- decreases the interval, making the timer more frequent
function VariableTimer:decreaseInterval(multiplier)
  VariableTimer.super.decreaseInterval(multiplier)
  self.interval_high = self.interval_high - self.interval_high * multiplier
end


return VariableTimer