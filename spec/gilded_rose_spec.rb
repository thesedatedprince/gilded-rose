require_relative '../lib/gilded_rose'
require_relative '../lib/item.rb'

describe GildedRose do

  describe "#update_quality" do

    context "Generic items" do
      it "does not change the name" do
        items = Item.new("foo", 0, 0)
        GildedRose.new.update_quality(items)
        expect(items.name).to eq "foo"
      end

      it "reduces quality of goods as they approach sell-by date" do
        items =Item.new("foo", 7, 10)
        GildedRose.new().update_quality(items)
        expect(items.quality).to eq 9
      end


      it "Reduces quality of goods at 2x speed after sell-by date has passed" do
        items =[Item.new("foo", 0, 10)]
        GildedRose.new().update_quality(items)
        expect(items.quality).to eq 8
      end

      # it "never allows quality of item to dip below 0" do
      #   items =[Item.new("foo", 0, 0)]
      #   GildedRose.new(items).update_quality()
      #   expect(items[0].quality).to eq 0
      # end

  end

    # context "Aged Brie" do
    #   it "increases in quality the older it gets" do
    #     items =[Item.new("Aged Brie", 6, 10)]
    #     GildedRose.new(items).update_quality()
    #     expect(items[0].quality).to eq 11
    #   end
    #
    #   it "doesn't allow quality to go above 50" do
    #     items =[Item.new("Aged Brie", 6, 50)]
    #     GildedRose.new(items).update_quality()
    #     expect(items[0].quality).to eq 50
    #   end
    # end
    #
    # context "Sulfuras, Hand of Ragnaros" do
    #   it "cannot decrease in quality" do
    #     items =[Item.new("Sulfuras, Hand of Ragnaros", 6, 10)]
    #     GildedRose.new(items).update_quality()
    #     expect(items[0].quality).to eq 10
    #   end
    # end
    #
    # context "Backstage passes" do
    #   it "Increases in quality by 2 when at 10 days or less" do
    #     items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
    #     GildedRose.new(items).update_quality()
    #     expect(items[0].quality).to eq 12
    #   end
    #   it "Increases in quality by 3 when at 5 days or less" do
    #     items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
    #     GildedRose.new(items).update_quality()
    #     expect(items[0].quality).to eq 13
    #   end
    #   it "Reduces in quality to 0 after the concert date" do
    #     items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
    #     GildedRose.new(items).update_quality()
    #     expect(items[0].quality).to eq 0
    #   end
    # end
  end
end
