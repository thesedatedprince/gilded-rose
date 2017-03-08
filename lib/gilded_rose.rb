require 'item.rb'

class GildedRose

  def initialize()
    @items = {}
  end

  def update_quality(item)
    degrade_rate = @items[item.name.to_sym][0]
    item.quality -= degrade_rate
  end


  def rules_generator(item, initial_quality_speed = 1, quality_change = 1, day_change = 0)
    @items[item.name.to_sym] = [initial_quality_speed, day_change]
  end


end
