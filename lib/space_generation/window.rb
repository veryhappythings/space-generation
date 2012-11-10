class GameWindow < Chingu::Window
  def initialize
    super(1024, 576)
    push_game_state(Play)
  end
end
