class Items
  @items = {}
  def initialize(name, price)
    @items[name] = price
  end

  def self.all
    @items
  end
end

class SaleItems
  @sale_items = {}
  def initialize(name, units, price)
    @sale_items[name] = { 'units' => units, 'price' => price }
  end

  def self.all
    @sale_items
  end
end

class PriceCalculator
  def get_input
    puts "Please enter all the items purchased separated by a comma"
    response = gets.chomp
  end
  
  def display_bill
    puts "Item     Quantity      Price"
    puts "--------------------------------------"
    puts "Total price : #{calculated price}"
    puts "You saved #{saved_price} today."
  end
end
