require_relative './black_jack'
require_relative './dealer'
require_relative './user'
require_relative './card_deck'
require_relative './cards'
require_relative './visualization'

puts "Приветствую в игре"
puts "Введите свою погремуху"
# user_name = gets.chomp
bj = BlackJack.new(gets.chomp)
bj.start