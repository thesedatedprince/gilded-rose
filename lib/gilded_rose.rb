require 'item.rb'

class GildedRose
  attr_reader :items

  def initialize()
    @items = {}
  end

  def update_quality(item)
    quality_speed_update(item)
    degrade_rate = quality_calc(item, @items[item.name.to_sym][0])
    item.quality += degrade_rate
  end

  def add_item(item, quality_change_rate = -1)
    @items[item.name.to_sym] =[quality_change_rate]
  end

  def add_rule(item, speed_change_day, new_speed)
    @items[item.name.to_sym].push [speed_change_day, new_speed]
  end

  def quality_speed_update(item)
    update_speed(item) if change_date? (item)
  end

  private

  def change_date? (item)
    item.sell_in == @items[item.name.to_sym][1][0]
  end

  def update_speed (item)
    @items[item.name.to_sym][0] = @items[item.name.to_sym][1][1]
  end

  def quality_calc (item, degrade_rate)
    item.quality + degrade_rate > 0 ? degrade_rate : -item.quality
  end
end
