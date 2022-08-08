class Market
  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory.include?(item)
    end
  end


  def total_inventory
    total = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.map do |item, amount|
        require 'pry'; binding.pry

          total[item] = {
            quantity: vendor.check_stock(item),
            vendors: vendors_that_sell(item)

        }

      end
    end
    total
  end
end
