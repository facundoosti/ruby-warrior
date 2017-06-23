class Player
    @health = nil
    def play_turn(warrior)
        @health ||= warrior.health
        if warrior.feel.wall?
            warrior.pivot!
        elsif warrior.feel.empty?
          if warrior.health < 20 && warrior.health >= @health 
            warrior.rest!
          elsif warrior.health < 10 && warrior.feel.empty?
            warrior.walk!(:backward)
          else
            warrior.walk!
          end
        else
            subject_action warrior
        end

        @health = warrior.health
    end

    def subject_action warrior
        warrior.feel.captive? ? warrior.rescue! : warrior.attack!
    end
end
