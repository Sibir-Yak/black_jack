class BlackJack
  attr_reader :user, :dealer, :card_deck, :bank

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
    @card_deck = Card_Deck.new
    @viev = Visualization.new
    #  Пройденый этап чтобы не повторялось
    @passed_stage = []
    #Использованные карты
    # @used_cards = []
    @bank = 0
    # @dealer_points = 0
    # @user_points = 0
  end

  def start
    @card_deck.deck_building ; bet
    2.times {distribution(@user)}
    2.times {distribution(@dealer)}
    loop do
      @viev.visualization_user(self)
      @viev.visualization_dealer(self, nil)
      @viev.introduction(@passed_stage)   #пройденый этам передаем
      # puts "Выберете действие"
      # puts '1) Добавить карту'
      # puts '2) Пропуск хода'
      # puts '3) Открыть карты'
      user_choice = gets.chomp.to_i
      @passed_stage << user_choice
      case user_choice
      when 1
        distribution(@user)
        @viev.visualization_user(self)
      when 2
        distribution(@dealer) if @dealer.points <= 17
        @viev.visualization_dealer(self, nil)
      when 3
        distribution(@dealer) if @dealer.card.size == 2 && @dealer.points <= 17
        @viev.open_cards(self, "open")
        win
        return
      end
      break if user_choice.zero?
    end
    puts "Спасибо до свиданья, надеюсь вы всё просрали"
  end

#Раздача чел.
  def distribution(player)
    card = @card_deck.new_cards.sample
    @card_deck.card_delete(card)
    player.card.push(card)
    if player.points <= 10 && card.card_name == 'A'
      player.points += card.card_points
    elsif player.points > 10 && card.card_name == 'A'
      player.points += 1
    else
      player.points += card.card_points
    end

    # puts @used_cards[-1].card_name
    # puts @card_deck.new_cards.length
    # puts @user.card
    # @card_deck.new_cards.card_delete(self)
    # puts @used_cards[0].card_points

  end

  def win
    correction_points(@user)
    correction_points(@dealer)
    if @user.points > @dealer.points && @user.points <= 21
      @bank -= 20 && @user.bank += 20
      @viev.visualization_win(self, 1)
    elsif @user.points <= 21 && @dealer.points > 21
      @bank -= 20 && @user.bank += 20
      @viev.visualization_win(self, 1)
    elsif @user.points == @dealer.points && @user.points <= 21
      @bank -= 20 && @user.bank += 10 && @dealer.bank += 10
      @viev.visualization_win(self, 2)
    elsif @user.points == @dealer.points && @user.points > 21
      @viev.visualization_win(self, 3)
    elsif @user.points > 21 && @dealer.points > 21
      @viev.visualization_win(self, 3)
    else
      @bank -= 20 && @dealer.bank += 20
      @viev.visualization_win(self, 4)
    end
    another_game
  end

#Убираем 10 очков если есть тузец, а очей многовато.
  def correction_points(player)
    player.card.each do |card|
      card_name = card.card_name
      if player.points > 21 && card_name == 'A'
        player.points -= 10
      end
    end

  end

  def another_game
    @passed_stage.clear
    @dealer.card.clear && @user.card.clear
    @dealer.points = 0 && @user.points = 0
    start
  end
  #Ставка
  def bet
    @user.bank -= 10
    @dealer.bank -= 10
    @bank += 20
  end

end