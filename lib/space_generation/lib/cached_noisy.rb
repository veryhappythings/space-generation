require 'json'
class CachedNoisy
  attr_accessor :data
  def initialize(seed, octaves)
    @noise = Noisy::Noisy.new(seed, octaves)
    @data = {}
  end

  def perlin_noise_2d(x, y)
    key = "#{x},#{y}"
    if !@data.has_key?(key)
      @data[key] = @noise.perlin_noise_2d(x, y)
    end
    return @data[key]
  end

  def save(filename)
    File.open(filename, 'w') do |f|
      f.write(JSON.dump(@data))
    end
  end

  def load(filename)
    File.open(filename, 'r') do |f|
      @data = JSON.load(f.read)
    end
  end
end
