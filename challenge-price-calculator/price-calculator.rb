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
