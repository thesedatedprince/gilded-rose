require_relative '../lib/gilded_rose'
require_relative '../lib/item.rb'

describe GildedRose do

  describe "#update_quality" do

    context "Generic items" do

      before do
        @gilded_rose = GildedRose.new
      end

      it "does not change the name" do
        item = Item.new("foo", 0, 0)
        @gilded_rose.add_item(item)
        @gilded_rose.add_rule(item, 7, 2)
        @gilded_rose.update_quality(item)
        expect(item.name).to eq "foo"
      end

      it "reduces quality of goods as they approach sell-by date" do
        item =Item.new("foo", 7, 10)
        @gilded_rose.add_item(item)
        @gilded_rose.add_rule(item, 0, 2)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 9
      end


      it "Reduces quality of goods at 2x speed after sell-by date has passed" do
        item = Item.new("foo", 0, 10)
        @gilded_rose.add_item(item)
        @gilded_rose.add_rule(item, 0, -2)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 8
      end

      it "never allows quality of item to dip below 0" do
        item =Item.new("foo", 0, 0)
        @gilded_rose.add_item(item)
        @gilded_rose.add_rule(item, 0, -2)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 0
      end

      it "never allows quality of item to dip below 0 - even if subtracting from a non-zero" do
        item =Item.new("foo", 0, 1)
        @gilded_rose.add_item(item)
        @gilded_rose.add_rule(item, 0, -2)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 0
      end
  end

    context "Aged Brie" do
      before do
        @gilded_rose = GildedRose.new
      end
      it "increases in quality the older it gets" do
        item = Item.new("Aged Brie", 6, 10)
        @gilded_rose.add_item(item, 1)
        @gilded_rose.add_rule(item, 0, 1)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 11
      end

      it "doesn't allow quality to go above 50" do
        item = Item.new("Aged Brie", 6, 50)
        @gilded_rose.add_item(item, 1)
        @gilded_rose.add_rule(item, 0, 1)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 50
      end

      it "doesn't allow quality to go above 50 - even if adding from less than 50" do
        item = Item.new("Aged Brie", 6, 49)
        @gilded_rose.add_item(item, 2)
        @gilded_rose.add_rule(item, 0, 1)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 50
      end
    end

    context "Sulfuras, Hand of Ragnaros" do

      before do
        @gilded_rose = GildedRose.new
      end

      it "cannot decrease in quality" do
        item = Item.new("Sulfuras, Hand of Ragnaros", 6, 10)
        @gilded_rose.add_item(item, 0)
        @gilded_rose.add_rule(item, 0, 0)
        @gilded_rose.update_quality(item)
        expect(item.quality).to eq 10
      end
    end

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

  describe "#add_item" do
    before do
      @gilded_rose = GildedRose.new
    end
    it 'adds a new item to the items hash - basic quality speed of 1' do
        item =Item.new("foo", 7, 10)
        @gilded_rose.add_item(item)
        @gilded_rose.add_rule(item, 7, 2)
        expect(@gilded_rose.items).to eq({:foo => [-1, [7,2]]})
    end
    it 'can instantiate with different quality change speeds' do
        item =Item.new("foo", 7, 10)
        @gilded_rose.add_item(item, 2)
        @gilded_rose.add_rule(item, 0, 3)
        expect(@gilded_rose.items).to eq({:foo => [2, [0,3]]})
    end
  end

  describe "add_rule" do
    before do
      @gilded_rose = GildedRose.new
    end
    it "associates a rule set to each item" do
      item =Item.new("foo", 7, 10)
      @gilded_rose.add_item(item)
      @gilded_rose.add_rule(item, 7, 2)
      expect(@gilded_rose.items).to eq ({:foo => [-1, [7, 2]]})
    end
    it "can take multiple rule sets" do
      item =Item.new("foo", 7, 10)
      @gilded_rose.add_item(item)
      @gilded_rose.add_rule(item, 7, 2)
      @gilded_rose.add_rule(item, 3, 5)
      expect(@gilded_rose.items).to eq ({:foo => [-1, [7, 2],[3, 5]]})
    end
  end

  describe "quality_speed_update" do
    before do
      @gilded_rose = GildedRose.new
    end
    it "updates the degrade rate when it hits a specified day" do
      item =Item.new("foo", 7, 10)
      @gilded_rose.add_item(item)
      @gilded_rose.add_rule(item, 7, -2)
      @gilded_rose.quality_speed_update(item)
      expect(@gilded_rose.items).to eq ({:foo => [-2, [7, -2]]})
    end
  end
end
