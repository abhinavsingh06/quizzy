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
  def generate_bill
    input = get_input.split(',').map(&:strip)
    @purchased_items = input
    if purchased_items.empty?
      puts "First add items to generate bill"
    else 
      quantity = count_items
      price = calculate_bill(quantity)
      billing_items = quantity.each_with_object(price) do |(key,value), billing_items| 
        billing_items[key] = {'units' => value, 'price' => price[key]} 
      end
      display_bill(billing_items, quantity)
    end
  end

  def get_input
    puts "Please enter all the items purchased separated by a comma"
    response = gets.chomp
  end

  def count_items
    @purchased_items.inject(Hash.new(0)) do |quantity, item|
      quantity[item] += 1
      quantity
    end
  end
  
  def calculate_bill(quantity)
    quantity.map { |item,value| [item, SalesItems.all[item].nil? ? quantity[item]*Items.all[item] : (((quantity[item]/SaleItems.all[item]['units']).floor)*SaleItems.all[item]['price']) + ((quantity[item]%SaleItems.all[item]['units'])*Items.all[item])] }.to_h
  end
  
  def display_bill(billing_items, quantity)
    puts "Item     Quantity      Price"
    puts "--------------------------------------"
    puts "Total price : #{calculated price}"
    puts "You saved #{saved_price} today."
  end
end
