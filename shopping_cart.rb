# Write the code for a supermarket checkout that can calculate the price of any number of items 
# taken from a predetermined list. Each item should be priced individually, and the checkout should 
# be able to scan them in any order.

# The requirements for the system are as follows:

# As a shopper
# So I know how much an item costs
# I would like to be able to see its price

# As a shopper
# So that I can buy an item
# I would like to be able to scan items at the checkout

# As a shopper
# So that I know if I have made a mistake
# I should be informed if I attempt to buy an item which is not available

# As a shopper
# So that I know how much to pay
# I would like to be able to see a total for all scanned items

# As a shopper
# So that I know how much to pay
# I would like to see all prices correctly formatted (£xx.xx)

# As a shopper 
# So that I am not left out of pocket
# I would like to receive the correct change once I have completed my transaction

# TODO: add a command-line runner

require 'bigdecimal'


class Supermarket
  def initialize(merchandise = [])
    @merchandise = merchandise
    @scanned = []
    @total_paid = BigDecimal(0, 2)
  end

  def price(name)
    format(retrieve(name).price)
  end

  def scan(name)
    @scanned.push(retrieve(name))
  end

  def total()
    "Number of items: #{@scanned.length}\nTotal: #{format(add_up())}"
  end

  def pay(amount_paid)
    @total_paid = @total_paid + BigDecimal(amount_paid, 2)
    change = amount_paid - add_up
    if change >= 0
      return "Your change: #{format(change)}"
    else
      return "You haven't paid enough! Get back here!"
    end
    
  end

  private
  def format(amount)
    string = (amount.truncate(2).to_s('F') + '00')[ /.*\..{2}/ ]
    "£#{string}"
  end

  def retrieve(name)
    @merchandise.select { |item| item.name == name }[0]
  end

  def add_up
    @scanned.reduce(0) do |accumulator, item|
      accumulator + item.price
    end
  end

end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = BigDecimal(price, 2)
  end

end

test_merch = [
  Item.new("bread", 1.12),
  Item.new("milk", 1.78),
  Item.new("avocados", 2.50),
  Item.new("champagne", 75.01)
]

test_market = Supermarket.new(test_merch)

puts test_market.price("bread")

test_market.scan("bread")
test_market.scan("milk")

puts test_market.total

puts test_market.pay(3.50)