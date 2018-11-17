-- functions related to a timer
-- @author Thomas Breese

Timer = Object:extend()

-- constructor
function Timer:new(start_time, interval)
  self.start_time = start_time
  self.last_time = start_time
  self.interval = interval
end

-- return whether or not the timer is ready
-- this means it has ticked past it's next interval
function Timer:isReady()
  local current_time = love.timer.getTime()
  if current_time - self.last_time >= self.interval then
    self.last_time = current_time
    return true
  end
  return false
end

-- mutator for interval
function Timer:setInterval(interval)
  self.interval = interval
end

-- accessor for interval
function Timer:getInterval()
  return self.interval
end

-- increases the interval, making the timer less frequent
function Timer:increaseInterval(multiplier)
  self.interval = self.interval + self.interval * multiplier
end

-- decreases the interval, making the timer more frequent
function Timer:decreaseInterval(multiplier)
  self.interval = self.interval - self.interval * multiplier
end

-- returns the time since the start
function Timer:getDuration()
  return love.timer.getTime() - self.start_time
end

return Timer