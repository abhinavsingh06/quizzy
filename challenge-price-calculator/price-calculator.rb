class Items
  @@items = {}
  def initialize(name, price)
    @@items[name] = price
  end
  
  def self.all
    @@items
  end
end

class SaleItems
  @@sale_items = {}
  def initialize(name, units, price)
    @@sale_items[name] = { 'units' => units, 'price' => price }
  end

  def self.all
    @@sale_items
  end
end

class PriceCalculator
  def generate_bill
    input = get_input.split(',').map(&:strip)
    @purchased_items = input
    if @purchased_items.empty?
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
    quantity.map { |item,value| [item, SaleItems.all[item].nil? ? quantity[item]*Items.all[item] : (((quantity[item]/SaleItems.all[item]['units']).floor)*SaleItems.all[item]['price']) + ((quantity[item]%SaleItems.all[item]['units'])*Items.all[item])] }.to_h
  end
  
  def display_bill(billing_items, quantity)
    total_price = billing_items.inject(0) do |total, (item,value)|
      total + value['price']
    end

    actual_price = quantity.inject(0) do |total, (item,units)| 
      total + (units * Items.all[item])
    end

    puts "Item     Quantity      Price"
    puts "--------------------------------------"
    billing_items.each do |item, value|
      puts "#{item.ljust(10)} #{value['units']}           $#{value['price']}"
    end
    puts "Total price : #{total_price.round(3)}"
    puts "You saved #{(actual_price - total_price).round(3)} today."
  end
end

begin
  Items.new('milk', 3.97)
  Items.new('bread', 2.17)
  Items.new('banana', 0.99)
  Items.new('apple', 0.89)
  SaleItems.new('milk',2,5.00)
  SaleItems.new('bread',3,6.00)
  price_calculator = PriceCalculator.new
  puts price_calculator.generate_bill
end
