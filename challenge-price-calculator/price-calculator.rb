module PriceList
  def item_unit_price(item)
    { milk: 3.97, bread: 2.17, banana: 0.99, apple: 0.89 }[item.to_sym]
  end

  def items_on_sale(item)
    { milk: { price: 5.00, quantity: 2 }, bread: { price: 6.00, quantity: 3 } }[item.to_sym]
  end
end

module Store
  class Product
    attr_reader :name, :price, :sale_price, :sale_quantity

    def initialize(name, price, sale_price = nil, sale_quantity = nil)
      @name = name
      @price = price
      @sale_price = sale_price
      @sale_quantity = sale_quantity
    end
  end

  class Cart
    include PriceList

    attr_reader :products

    def initialize(items)
      @items = items
      @quantity = {}
      @products = {}
      @product_price = {}
    end

    def calculate_quantity
      @items.each do |item|
        if @products[item]
          increment_quantity(item)
        else
          sale = items_on_sale(item)
          if sale
            @products[item] = Product.new(item, item_unit_price(item), sale[:price], sale[:quantity])
          else
            @products[item] = Product.new(item, item_unit_price(item))
          end
          @quantity[item] = 1
        end
      end
      @quantity
    end

    def calculate_total_price
      @products.inject(0) do |total, (product_name, product)|
        total + calculate_price(@products[product_name], @quantity[product_name])
      end
    end

    def calculate_saved_price
      @products.inject(0) do |saved, (product_name, product)|
        saved + saved_price(@products[product_name], @quantity[product_name])
      end
    end

    private

      def increment_quantity(item)
        @quantity[item] += 1
      end

      def calculate_price(product, quantity)
        price = product.price
        name = product.name
        if product.sale_price
          sale_price = product.sale_price
          sale_quantity = product.sale_quantity
          @product_price[name] = (quantity / sale_quantity) * sale_price + (quantity % sale_quantity) * price
        else
          @product_price[name] = quantity * price
        end
      end
      
      def saved_price(product, quantity)
        price = product.price
        price * quantity - calculate_price(product, quantity)
      end
  end
  
  class Bill
    def get_order
      puts "Please enter all the items purchased separated by a comma:"
      response = gets.chomp
      items = response.split(',').map(&:strip)
      generate_bill(items)
    end

    private

      def generate_bill(items)
        cart = Cart.new(items)
        products = cart.products
        quantity = cart.calculate_quantity
        total_price = cart.calculate_total_price
        saved_price = cart.calculate_saved_price
        display_bill(products, quantity, total_price, saved_price)
      end

      def display_bill(products, quantity, total_price, saved_price)
        puts "Item     Quantity      Price"
        puts "--------------------------------------"
        products.each do |item, value|
          puts "#{item.ljust(10)} #{quantity[item]}           $#{value.price}"
        end
        puts "Total price : $#{total_price.round(3)}"
        puts "You saved $#{saved_price.round(3)} today."
      end
  end
end

begin
  order = Store::Bill.new
  order.get_order
end
