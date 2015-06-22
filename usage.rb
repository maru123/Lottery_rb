require './lib/lottery'

lottery = Lottery.new(2)
lottery.add("John", 1)
lottery.add("Jane", 3)
lottery.add("Matz", 5)
lottery.add("Matz", 5)
lottery.add("", 5)
lottery.add("Alice", 0)
lottery.add("Bob", -1)

# 100000.times do
   lottery.selectWinners
# end
puts "Members: #{lottery.members.uniq} \nWinners: #{lottery.winners}"
