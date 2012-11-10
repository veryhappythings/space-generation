class Chunk < Chingu::BasicGameObject
  HEIGHT = 1000
  WIDTH = 1000
  DUST_DENSITY = 10
  DUST_CHANCE = 0.05
  STAR_CHANCE = 0.1
  MAX_BRIGHTNESS = 320

  attr_reader :x, :y

  def initialize(x, y, noise)
    @x = x
    @y = y

    rand = Random.new(42)
    start = Time.new
    @spacedust = TexPlay.create_blank_image($window, HEIGHT, WIDTH)
    @spacedust.paint do
      (0..WIDTH-1).step(DUST_DENSITY).each do |nx|
        (0..HEIGHT-1).step(DUST_DENSITY).each do |ny|
          random = rand.rand
          if random < DUST_CHANCE # Dust
            shading = noise.perlin_noise_2d(nx + x, ny + y)
            pixel nx, ny, :color => [1.0, 1.0, 1.0, shading.abs]
          elsif random > (1 - STAR_CHANCE)
            shading = noise.perlin_noise_2d(nx + x, ny + y)
            brightness = shading * MAX_BRIGHTNESS
            size = shading * 5
            if brightness < 100 # Small stars
              circle nx, ny, size, :color => [1.0, 1.0, 1.0, shading.abs], :fill => true
            else # Bright stars
              circle nx, ny, size, :color => [1.0, 1.0, 1.0, shading.abs], :fill => true
              circle nx, ny, size + 2, :color => [1.0, 1.0, 1.0, shading.abs * 0.3]
              circle nx, ny, size + 3, :color => [1.0, 1.0, 1.0, shading.abs * 0.1]
              circle nx, ny, size + 4, :color => [1.0, 1.0, 1.0, shading.abs * 0.05]
            end
          end
        end
      end
    end
    puts "Creation time #{Time.new - start}"
  end

  def draw
    @spacedust.draw(
      @x-$window.game_state_manager.current_game_state.viewport.x,
      @y-$window.game_state_manager.current_game_state.viewport.y,
      0
    )
  end
end
