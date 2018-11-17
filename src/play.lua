-- class to perform the events to play the game
-- @author Thomas Breese

Play = Object:extend()

-- create a new instance
function Play:new(player, levels)
  self.player = player
  -- game contains levels and their configuration
  self.levels = levels
  self.current_level = 1
  self.score = Score()
  self.listOfProjectiles = {}
  self.listOfEnemies = {}
  self.releaseTimer = Timer(love.timer.getTime(), 0)
  self.enemyTimer = Timer(love.timer.getTime(), 0)
  self.gameTimer = Timer(love.timer.getTime(), 0)
  
  --configure the level values
  self:configureLevel(self.current_level)
end

-- function to configure the settings of a level when a level is set
function Play:configureLevel(level)
  -- being the level timer, marking it as started
  self.levels[level]:start()
  self.releaseTimer:setInterval(self.levels[level]:getReleaseInterval())
  self.enemyTimer:setInterval(self.levels[level]:getEnemyInterval())
  self.player:setSpeed(self.levels[level]:getPlayerSpeed())
  self.score:setPointValue(self.levels[level]:getPointValue())
  self.score:setMultiplier(self.levels[level]:getPointMultiplier())
  -- update each enemies speed
  for i, enemy in ipairs(self.listOfEnemies) do
    enemy:setSpeed(self.levels[level]:getEnemySpeed())
  end
  -- update each projectile's speed
  for i, projectile in ipairs(self.listOfProjectiles) do
    projectile:setSpeed(self.levels[level]:getProjectileSpeed())
  end
end

-- update the game
function Play:update(dt)
  -- check if we can move on to the next level
  -- TODO: need to branch on what's passed to completed to check victory condition for level type
  if self.levels[self.current_level]:isStarted()
  and self.levels[self.current_level]:completed(love.timer.getTime()) then
    -- mark the level completed
    self.levels[self.current_level]:finish(love.timer.getTime())
    -- check if we have completed all levels (won the game)
    if self.current_level == #self.levels then
      -- game is completed!
      -- print('game completed!')
    else 
      -- move on to the next level
      self.current_level = self.current_level + 1
      self:configureLevel(self.current_level)
    end
  end
  
  -- update the player
  self.player:update(dt)
  
  -- check if we need to create a new projectile
  if self.releaseTimer:isReady() then
    table.insert(self.listOfProjectiles, Projectile.createRelativeTo(self.player))
  end
  
  -- check if it's time to spawn an enemy
  if self.enemyTimer:isReady() then
    -- create a new enemy instance
    -- create this out of an existing projectile perhaps?
    table.insert(self.listOfEnemies, Enemy(0,0, self.player))
  end
  
  -- check if the enemy collided with the player or the projectiles
  for i,enemy in ipairs(self.listOfEnemies) do
    enemy:update(dt)
    if checkCollision(enemy, self.player) then
      -- decrease the score and slow down the player
      self.score:decrement()
      self.player:decreaseSpeed()
      -- remove the enemy
      table.remove(self.listOfEnemies, i)
      -- make the projectiles rapido!
      -- TODO: these increases need to be configured somewhere
      -- possibly on the enemy or player objects, but not sure yet
      -- could also be the level, might be most apporpriate as
      -- level is handling scaling values
      self.releaseTimer:decreaseInterval(.005)
      self.enemyTimer:increaseInterval(.001)
    else
      -- check if the enemies collided with a projectile
      -- in this case they speed up
      for j,projectile in ipairs(self.listOfProjectiles) do
        if checkCollision(enemy, projectile) then
          enemy:increaseSpeed()
          -- remove the projectile
          table.remove(self.listOfProjectiles, j)
        end
      end
      
      -- check if the enemy has expired
      if enemy:hasLifeExpired(love.timer.getTime()) then
        table.remove(self.listOfEnemies, i)
      end
    end
  end
  
  -- check if the projectile have collided with the player
  for i,projectile in ipairs(self.listOfProjectiles) do
    projectile:update(dt)
    if checkCollision(projectile, self.player) then
      self.score:increment()
      -- increase player speed
      self.player:increaseSpeed()
      -- remove the projectile
      table.remove(self.listOfProjectiles, i)
      -- make the enemies spawn faster
      self.enemyTimer:decreaseInterval(.001)
    end
    -- if the projectile went off the screen, remove it
    if projectile:getKilled() then
      table.remove(self.listOfProjectiles, i)
    end
  end
  
  -- TODO: move this to a more appropriate place, but check projectile to projectile collisions
  for i, projectile in ipairs(self.listOfProjectiles) do
    for j, inner_projectile in ipairs(self.listOfProjectiles) do
      if j > i and checkCollision(self.listOfProjectiles[i], self.listOfProjectiles[j]) then
        -- collision, absorb the first into the second so that we cna chain them
        self.listOfProjectiles[j]:decreaseSpeed()
        self.listOfProjectiles[j]:scale(3)
        -- remove the current projectile
        table.remove(self.listOfProjectiles, i)
      end
    end
  end
  
end

-- draw the game
function Play:draw()
  -- display the current level
  love.graphics.print(self.levels[self.current_level]:getName(), 10, love.graphics.getHeight() - 20)
  -- display the score
  love.graphics.print(self.score:getScore(), 100, love.graphics.getHeight() - 20)
  -- display the timer
  love.graphics.print(self.gameTimer:getDuration(), 10, love.graphics.getHeight() - 40)
  
  -- draw the player and objects
  self.player:draw()
  
  for i,projectile in ipairs(self.listOfProjectiles) do
    projectile:draw()
  end
  
  for i,enemy in ipairs(self.listOfEnemies) do
    enemy:draw()
  end
end

return Play