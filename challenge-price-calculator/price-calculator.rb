module Shop
  class Stock
    attr_reader :items

    def initialize(*items)
      @items = Array(items)
    end
    
    def retreive(name)
      items.find { |item| item.name == name }
    end
    
    StockItem = Struct.new(:name, :price, keyword_init: true)

    def self.with(*item_attributes)
      new(
        *item_attributes.map { |attrs| StockItem.new(**attrs) }
      )
    end
  end

  class BundleDiscount
    def initialize(*bundle_discounts)
      @all = Array(bundle_discounts)
    end
    
    def find(item:, quantity:)
      @all
      .sort_by(&:size)
      .reverse
      .find { |discount| discount.item_name == item.name && discount.size <= quantity }
    end
    
    ItemBundleDiscount = Struct.new(:item_name, :size, :bundle_price, keyword_init: true) do
      def sum_with_applied_discount(item_price, item_quantity)
        ((item_quantity / size) * bundle_price) + ((item_quantity % size) * item_price)
      end
    end

    def self.with(*bundle_discount_attrs)
      new(
        *bundle_discount_attrs.map { |attrs| ItemBundleDiscount.new(**attrs) }
      )
    end
  end
end

class Order
  attr_reader :bundle_discounts

  def initialize(items:, bundle_discounts:)
    @items = items
    @bundle_discounts = bundle_discounts
  end

  def items
    @items
      .group_by(&:name)
      .map { |name, items|
        item = items.first
        OrderItem.new(
          name: item.name,
          price: item.price,
          quantity: items.size,
          bundle_discount: bundle_discounts.find(item: item, quantity: items.size)
        )
      }
  end

  def empty?
    @items.empty?
  end

  def gross_sum
    items.sum(&:gross_sum)
  end

  def sum
    items.sum(&:sum)
  end

  def total_discount
    gross_sum - sum
  end

  private

  OrderItem = Struct.new(:name, :price, :quantity, :bundle_discount, keyword_init: true) do
    def sum
      if bundle_discount
        bundle_discount.sum_with_applied_discount(price, quantity)
      else
        gross_sum
      end
    end

    def gross_sum
      price * quantity
    end
  end
end

# These are responsible to display domain objects on the screen
module Views
  class Receipt
    def initialize(order)
      @order = order
    end

    def to_s
      <<~RECEIPT
        Item     Quantity      Price
        --------------------------------------
        #{line_items.join("\n")}
        #{order_summary}
      RECEIPT
    end

    def line_items
      @order.items.map { |item|
        "#{item.name.ljust(10)} #{item.quantity}           $#{item.sum.round(3)}"
      }
    end

    def order_summary
      <<~SUMMARY
        Total price : $#{@order.sum.round(3)}
        You saved $#{@order.total_discount.round(3)} today.
      SUMMARY
    end
  end

  class OrderSummary
    def initialize(order)
      @order = order
    end

    def to_s
      <<~SUMMARY
        Order summary:
        Item     Quantity
        -----------------
        #{line_items.join("\n")}
      SUMMARY
    end

    private

    def line_items
      @order.items.map { |item|
        "#{item.name.ljust(10)} #{item.quantity}"
      }
    end
  end
end

# The PurchaseProcess is responsible for gathering and responding to user input
class PurchaseProcess
  def initialize(stock:, bundle_discounts:)
    @stock = stock
    @bundle_discounts = bundle_discounts
  end

  def initiate
    puts "Please enter all the items purchased separated by a comma"
    order = receive_customer_order

    if order.empty?
      "No available products chosen"
      initiate
    elsif receive_customer_order_confirmation(order)
      puts Views::Receipt.new(order)
      puts "Than you for your purchase!"
    else
      puts "Plese come back another time!"
    end
  end

  def receive_customer_order
    item_names = gets.chomp.split(",").map(&:strip).compact
    items = item_names.map { |name| stock.retreive(name) }.compact

    Order.new(items: items, bundle_discounts: bundle_discounts)
  end

  def receive_customer_order_confirmation(order)
    puts Views::OrderSummary.new(order)
    puts "Please confirm your order"
    puts "y/n"
    response = gets.chomp.downcase.strip

    response == "y"
  end

  private

  attr_reader :stock, :bundle_discounts
end

# The ”main” part of the program, setup the inventory and run the process
purchase =
  PurchaseProcess.new(
    stock: Shop::Stock.with(
      {name: 'milk', price: 3.97},
      {name: 'bread', price: 2.17},
      {name: 'banana', price: 0.99},
      {name: 'apple', price: 0.89}
    ),
    bundle_discounts: Shop::BundleDiscount.with(
      {item_name: 'milk', size: 2, bundle_price: 5.00},
      {item_name: 'bread', size: 3, bundle_price: 6.00}
    )
  )

purchase.initiate
