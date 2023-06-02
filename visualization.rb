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
end