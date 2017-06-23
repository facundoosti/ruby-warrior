class Player
    @health = nil
    def play_turn(warrior)
        @health ||= warrior.health
        @spaces = warrior.look
        if show(warrior) == true
            warrior.feel.captive? ? warrior.rescue! : warrior.walk!
        elsif show(warrior) == false
            warrior.shoot!
        else
            warrior.walk!
        end
    end

    def show(warrior)
        if warrior.look.map(&:captive?).any?
            true
        elsif warrior.look.map(&:enemy?).any?
            false
        end
    end
end
