# frozen_string_literal: true

class Visualization
  def introduction(passed_stage)
    if passed_stage.empty?
      puts 'Выберете действие'
      puts '1) Добавить карту'
      puts '2) Пропуск хода'
    elsif passed_stage.include?(1) && !passed_stage.include?(2)
      puts '2) Пропуск хода'
    elsif passed_stage.include?(2) && !passed_stage.include?(1)
      puts '1) Добавить карту'
    end
    puts '3) Открыть карты'
  end

  def visualization_step(player, open)
    puts "#{player.name} карты:"
    if open == true
      puts '*' * player.card.length
      # Удалить нижнюю строку в конце!!!!!!!!!!
      # puts "У #{player.name} очков: #{player.points}"
    else
      player.card.each do |card|
        print card.card_name
        puts card.card_suits
      end
      puts "У #{player.name} очков: #{player.points}"
    end
    puts "Денег осталось: #{player.bank}"
    puts
  end

  def visualization_win(black_jack, who_wins)
    user_points = black_jack.user.points
    dealer_points = black_jack.dealer.points
    user_money = black_jack.user.bank
    dealer_money = black_jack.dealer.bank
    case who_wins
    when :user
      puts "Вы #{black_jack.user.name} ПОБЕДИЛИ"
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    when :draw
      puts 'НИЧЬЯ'
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    when :dealer
      puts "Ув. #{black_jack.user.name}, #{black_jack.dealer.name} победил"
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    end
  end

  def bank_zero(player)
    case player
    when 1
      puts 'Денег у вас больше нет. До свидания'
    when 2
      puts 'Диллер всё проиграл'
    end
  end

  def another_game
    puts 'Еще катаем?'
    puts '1) Еще'
    puts '2) Хватит'
    case gets.chomp.to_i
    when 1
      nil
    when 2
      abort
    end
  end
end
