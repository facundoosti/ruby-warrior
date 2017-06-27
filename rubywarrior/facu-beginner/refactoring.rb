#1
class Player
  def play_turn(warrior)
    warrior.walk!
  end
end

#2
class Player
  def play_turn(warrior)
    warrior.feel.empty? ? warrior.walk! : warrior.attack! 
  end
end

#3, 4
class Player
    def play_turn(warrior)
        @health  ||= warrior.health
        moving warrior
        @health = warrior.health
    end
    
    def moving warrior
        return warrior.attack! unless warrior.feel.empty?
        return warrior.rest! if  warrior.health < 20 and  warrior.health >= @health
        warrior.walk!
    end
end

#5
class Player
    def play_turn(warrior)
        @health ||= warrior.health
        moving warrior
        @health = warrior.health
    end
    def moving warrior
        return warrior.attack! if !warrior.feel.empty? and !warrior.feel.captive?
        return warrior.rescue! if !warrior.feel.empty? and warrior.feel.captive?
        return warrior.rest! if  warrior.health < 20 and  warrior.health >= @health
        warrior.walk!
    end
end

#6
class Player
    def play_turn(warrior)
        @health ||= warrior.health
        moving warrior
        @health = warrior.health
    end
    def moving warrior
        return warrior.attack! if !warrior.feel.empty? and !warrior.feel.captive?
        return warrior.rescue! if !warrior.feel.empty? and warrior.feel.captive?
        return warrior.walk! :backward if  warrior.health < 10 and  warrior.health < @health
        return warrior.rest! if  warrior.health < 20 and  warrior.health >= @health
        warrior.walk!
    end
end

#7
class Player
    def play_turn(warrior)
        @health ||= warrior.health
        moving warrior
        @health = warrior.health
    end
    def moving warrior
        return warrior.pivot!   if warrior.feel.wall?
        return warrior.attack!  if !warrior.feel.empty? and !warrior.feel.captive?
        return warrior.rescue!  if !warrior.feel.empty? and warrior.feel.captive?
        return warrior.walk! :backward if  warrior.health < 10 and  warrior.health < @health
        return warrior.rest! if  warrior.health < 20 and  warrior.health >= @health
        warrior.walk!
    end
end

#8
class Player
    def play_turn(warrior)
        @health  ||= warrior.health
        @warrior = warrior
        moving warrior
    end

    def moving
        return @warrior.rescue! if look_captive? and @warrior.feel.captive?
        return @warrior.walk!   if look_captive? and !@warrior.feel.captive?
        return @warrior.shoot!  if look_enemy?
        @warrior.walk!
    end

    def look_enemy?
        @warrior.look.map(&:enemy?).any?
    end

    def look_captive?
        @warrior.look.map(&:captive?).any?
    end
end

#9
class Player
  def play_turn(warrior)
    @health  ||= warrior.health
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


  
