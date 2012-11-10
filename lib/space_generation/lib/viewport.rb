module Chingu
  class Viewport
    def x=(x)
      @x = x
    end
    def y=(y)
      @y = y
    end

    def inside_game_area?(object)
      true
    end
    def outside_game_area?(object)
      false
    end
  end
end
