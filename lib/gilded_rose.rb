class GildedRose

  def initialize()
  end

  def update_quality(item)
    degrade_rate = 1
    item.quality -= degrade_rate

  end


private

  def sell_by? (date)
    date <= 0
  end
end
