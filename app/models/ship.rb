class Ship < ActiveRecord::Base
  before_save :set_location_and_direction

  DOWN = 1
  RIGHT = 2

  def self.set_up_game_if_necessary
    if Ship.count < 10
      2.times do |player_index|
        [2,3,3,4,5].each do |ship_size|
          Ship.create(size: ship_size, player: player_index)
        end
      end
    end
  end

  def self.hit?(player, x, y)
    Ship.where(player: player).find_each do |ship|
      if ship.hit?(x,y)
        return true
      end
    end

    false
  end

  def hit?(hitx, hity)
    if direction == DOWN
      hity == y && hitx < x + size && hitx >= x
    else
      hitx == x && (hity < y + size) && hity >= y
    end
  end

  protected

  def set_location_and_direction
    loop do
      self.x = rand(10)
      self.y = rand(10)
      self.direction = [DOWN, RIGHT][rand(2)]
     break if ship_placement_legal?
    end 
  end

  def ship_placement_legal?
    if direction == RIGHT
      return false if (y + size) >= 10
      size.times do |i|
        return false if Ship.hit?(player, x, y + i)
      end
    else
      return false if (x + size) >= 10
      size.times do |i|
        return false if Ship.hit?(player, x + i, y)
      end
    end

    true
  end
end
