class Player < Chingu::GameObject
  trait :bounding_box
  trait :collision_detection
  trait :timer
  trait :velocity

  attr_accessor :target_x, :target_y
  attr_reader :dead

  DAMPENING = 0.6
  ACCELERATION = 2
  MAX_VELOCITY = 20

  def initialize(options={})
    super(options.merge(:image => Gosu::Image["player.png"]))

    @target_x = @x
    @target_y = @y

    @respawn_x = @x
    @respawn_y = @y

    self.max_velocity = MAX_VELOCITY

    cache_bounding_box
  end

  def update
    super

    self.velocity_y *= DAMPENING
    self.velocity_x *= DAMPENING
  end

  def die
    self.collidable = false
    between(1,600) { self.scale -= 0.05; self.alpha -= 5; }.then { resurrect }
  end

  def resurrect
    self.scale = 1
    self.alpha = 255
    self.collidable = true
    self.x = @respawn_x
    self.y = @respawn_y
    @target_x = @x
    @target_y = @y
  end

  def fire
    tx = $window.mouse_x + game_state.viewport.x
    ty = $window.mouse_y + game_state.viewport.y
    Bullet.create(
      :x => @x,
      :y => @y,
      :target_x => tx,
      :target_y => ty
    )
  end

  def current_acceleration
    ACCELERATION
  end

  def up
    self.acceleration_y = -current_acceleration
  end
  def down
    self.acceleration_y = current_acceleration
  end
  def right
    self.acceleration_x = current_acceleration
  end
  def left
    self.acceleration_x = -current_acceleration
  end
  def halt_x
    self.acceleration_x = 0.0
  end
  def halt_y
    self.acceleration_y = 0.0
  end
end
