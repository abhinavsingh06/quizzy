module PriceList
  def item_unit_price(item)
    { milk: 3.97, bread: 2.17, banana: 0.99, apple: 0.89 }[item.to_sym]
  end
 
  def sale_on_items(item)
    { milk: { price: 5.00, quantity: 2 }, bread: { price: 6.00, quantity: 3 } }[item.to_sym]
  end
end

module Shop
  class PurchaseOrder
    include PriceList
    attr_reader :quantity, :product_price
    def initialize
      @quantity = {}
      @product_price = {}
    end
   
    protected
    def calculate_total_price
      @quantity.inject(0) do |total, (item_name, item)|
        total + calculate_price(item_name)
      end
    end
   
    def calculate_saved_price
      @quantity.inject(0) do |saved, (item_name, item)|
        saved + saved_price(item_name)
      end
    end
   
    def count_items(input)
      @quantity = input.inject(Hash.new(0)) do |quantity, item|
        quantity[item] += 1
        quantity
      end
    end
   
    def calculate_price(item)
      sale = sale_on_items(item)
      quantity = @quantity[item]
      price = item_unit_price(item)
      if sale
        sale_quantity = sale[:quantity]
        sale_price = sale[:price]
        @product_price[item] = ((quantity / sale_quantity) * sale_price) + ((quantity % sale_quantity) * price)
      else
        @product_price[item] = quantity * price
      end
    end
   
    def saved_price(item)
      item_unit_price(item) * @quantity[item] - calculate_price(item)
    end
  end
  
  class Bill < PurchaseOrder
    def get_order
      puts "Please enter all the items purchased separated by a comma"
      input = gets.chomp
      input = input.split(',').map(&:strip)
      generate_bill(input)
    end
   
    def generate_bill(input)
      purchase_order = PurchaseOrder.new
      purchase_order.count_items(input)
      total = purchase_order.calculate_total_price
      saved = purchase_order.calculate_saved_price
      quantity = purchase_order.quantity
      product_price = purchase_order.product_price
      display_bill(product_price, quantity, total, saved)
    end
   
    def display_bill(product_price, quantity, total_price, saved_price)
      puts "Item     Quantity      Price"
      puts "--------------------------------------"
      quantity.each do |item, value|
        puts "#{item.ljust(10)} #{value}           $#{product_price[item]}"
      end
      puts "Total price : $#{total_price.round(3)}"
      puts "You saved $#{saved_price.round(3)} today."
    end
  end
end
 
begin
  order = Shop::Bill.new
  order.get_order
end
