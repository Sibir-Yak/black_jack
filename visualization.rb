class Visualization
  def introduction(passed_stage)
    if passed_stage.empty?
      puts "Выберете действие"
      puts '1) Добавить карту'
      puts '2) Пропуск хода'
      puts '3) Открыть карты'
    elsif passed_stage.include?(1) && !passed_stage.include?(2)
      puts '2) Пропуск хода'
      puts '3) Открыть карты'
    elsif passed_stage.include?(2) && !passed_stage.include?(1)
      puts '1) Добавить карту'
      puts '3) Открыть карты'
    else
      puts '3) Открыть карты'
    end
  end

  def visualization_user(black_jack)
    puts "Ваши карты:"
    black_jack.user.card.each do |card|
      print card.card_name
      puts card.card_suits
    end
    puts "Денег осталось: #{black_jack.user.bank}"
    puts "Ваши очки: #{black_jack.user.points}"
  end

  def visualization_dealer(black_jack, open)
    puts "Карты дилера:"
    if open == nil
      puts "*" * black_jack.dealer.card.length
    else
      black_jack.dealer.card.each do |card|
        print card.card_name
        puts card.card_suits
      end
    end
    puts "Денег осталось: #{black_jack.dealer.bank}"
    puts "Дилера очки: #{black_jack.dealer.points}"
  end

  def open_cards(black_jack, open)
    visualization_user(black_jack)
    visualization_dealer(black_jack, open)
  end

  def visualization_win(black_jack, num)
    user_points = black_jack.user.points
    dealer_points = black_jack.dealer.points
    user_money = black_jack.user.bank
    dealer_money = black_jack.dealer.bank
    case num
    when 1
      puts "Вы #{black_jack.user.name} ПОБЕДИЛИ"
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    when 2
      puts "НИЧЬЯ"
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    when 3
      puts "НИЧЬЯ, оба просрали"
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    when 4
      puts "Ув. #{black_jack.user.name} Дилер победил"
      puts "Ваши очки: #{user_points} Очки дилера: #{dealer_points}"
      puts "Ваши монеты: #{user_money} Монеты дилера: #{dealer_money}"
    end
    if user_money == 0
      puts "Денег у вас нет. До свидания"
      abort
    elsif dealer_money == 0
      puts "Диллер всё проиграл"
      abort
    else
      another_game
    end
  end

  def another_game
    puts "Еще катаем?"
    puts "1) Еще"
    puts "2) Хватит"
    case gets.chomp.to_i
    when 1
      return
    when 2
      abort
    end
  end
end