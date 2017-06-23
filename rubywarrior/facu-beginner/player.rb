class Player
  def play_turn(warrior)
    @health  ||= 20
    @warrior  = warrior
    
    moving
    
    @health = warrior.health
  end
  
  def moving
    return @warrior.pivot!   if @warrior.feel.wall?
    return @warrior.rescue!  if @warrior.feel.captive?
    return @warrior.attack!  if @warrior.feel.enemy?
    return @warrior.shoot!   if @warrior.look[2].enemy?
    return reconsider        if @warrior.health < @health
    return sleep_or_move     if @warrior.feel.empty?
  end
  
  def sleep_or_move
    (@warrior.health < 20) ? @warrior.rest! : move
  end
  
  def move(direction = :forward)
    @warrior.walk! direction
  end
  
  def reconsider
    move(@warrior.health < 10 ? :backward : :forward)
  end
end
