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

require 'bigdecimal'


class Supermarket
  def initialize(merchandise = [])
    @merchandise = merchandise
    @scanned = []
    @total_paid = BigDecimal(0, 2)
  end

  def price(name)
    for_sale(name) ? "#{name}: #{format(retrieve(name).price)}" : "#{name} is not for sale!"
  end

  def scan(name)
    for_sale(name) ? @scanned.push(retrieve(name)) : "#{name} is not for sale!"
  end

  def total()
    "Number of items: #{@scanned.length}\nTotal: #{format(add_up)}"
  end

  def pay(amount_paid)
    @total_paid = @total_paid + BigDecimal(amount_paid, 2)
    if change >= 0
      return "Total cost: #{format(add_up)}. Amount paid: #{format(@total_paid)}. Your change: #{format(change)}"
    else
      return "Total cost: #{format(add_up)}. Amount paid: #{format(@total_paid)}. You haven't paid enough! Get back here and pay #{format(0 - change)}!"
    end
    
  end

  def change
    @total_paid - add_up
  end

  def list
    @merchandise.reduce("Items for sale:") do |accumulator, item|
      accumulator + "\n#{item.name}: #{format(item.price)}"
    end
  end

  def settled
    BigDecimal(@total_paid) - add_up >= 0
  end

  def leave
    if settled
      change > 0 ? "Thanks, here is your #{format(change)} change. See you next time!" : "Thanks, have a nice day!"
    else
      "You can't leave until you've paid!" 
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
    @scanned.reduce(BigDecimal(0, 2)) do |accumulator, item|
      accumulator + item.price
    end
  end

  def for_sale(name)
    !@merchandise.select { |item| item.name == name }.empty?
  end
end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = BigDecimal(price, 2)
  end

end

def go_shopping(items)
  supermarket = Supermarket.new(items)
  action = ""
  until action == 'leave' && supermarket.settled
    action = get_action
    case action
    when  'scan', 'price', 'pay'
      argument = get_argument(action)
      action_method = action.to_sym
      puts supermarket.send(action_method, argument)
    when 'total', 'list', 'leave'
      puts supermarket.send(action.to_sym)

    end
  end
end

def get_action
  puts "Enter an action\nAvailable actions: list, price, scan, total, pay, leave"
  gets.chomp
end

def get_argument(action)
  puts "Enter what you want to #{action}"
  gets.chomp
end


test_merch = [
  Item.new("bread", 1.12),
  Item.new("milk", 1.78),
  Item.new("avocados", 2.50),
  Item.new("champagne", 75.01)
]

go_shopping(test_merch)
