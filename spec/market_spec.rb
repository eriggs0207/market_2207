require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before :each do
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @market = Market.new("South Pearl Street Farmers Market")
  end

  it 'does exist and has attributes' do
    expect(@market).to be_instance_of(Market)
    expect(@market.name).to eq("South Pearl Street Farmers Market")
    expect(@market.vendors).to eq([])
  end

  it 'can add vendors' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
  end

  it 'can return a list of vendor names' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can return a vendor that sells an item' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
  end

  it 'can return a total inventory' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expected_hash = {
                    @item1 => {
                      :quantity => 100,
                      :vendors => [
                        @vendor1,
                        @vendor3
                      ]

                  }, @item2 => {
                      :quantity => 7,
                      :vendors => [
                        @vendor1
                      ]
                  }, @item4 => {
                      :quantity => 50,
                      :vendors => [
                        @vendor2
                      ]
                  }, @item3 => {
                      :quantity => 35,
                      :vendors => [
                        @vendor2,
                        @vendor3
                      ]
                  },
    }
    expect(@market.total_inventory).to eq(expected_hash)
  end
end
