class Player
    @health = nil
    def play_turn(warrior)
       @health ||= warrior.health

        if warrior.feel.empty?
            if  warrior.health < 20 and  !(warrior.health < @health)
                warrior.rest!
            else
                warrior.walk!
            end
        else
            if warrior.feel.captive?
                warrior.rescue!
            else
                warrior.attack!
            end
        end
        @health = warrior.health
    end
end
