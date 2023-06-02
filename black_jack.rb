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
        @viev.open_cards(self, "open")
        return
      end
      break if user_choice.zero?
    end
    puts "Спасибо до свиданья, надеюсь вы всё просрали"
  end

#Раздача чел.
  def distribution(player)
    card = @card_deck.new_cards.sample
    # @used_cards << card
    @card_deck.card_delete(card)
    player.card.push(card)
    player.points += card.card_points

    # puts @used_cards[-1].card_name
    # puts @card_deck.new_cards.length
    # puts @user.card
    # @card_deck.new_cards.card_delete(self)
    # puts @used_cards[0].card_points

  end

  # def distribution_dealer
  #   card = @card_deck.new_cards.sample
  #   @used_cards << card
  #   @card_deck.card_delete(card)
  #   @dealer.card.push(card)
  #   @dealer_points += card.card_points
  # end

  #Ставка
  def bet
    @user.bank -= 10
    @dealer.bank -= 10
    @bank += 20
  end

  # def visualization_user
  #   puts "Ваши карты:"
  #   @user.card.each do |card|
  #     print card.card_name
  #     puts card.card_suits
  #   end
  #   puts "Денег осталось: #{@user.bank}"
  #   puts "Ваши очки: #{@user.points}"
  # end

  # def visualization_dealer
  #   puts "Карты дилера:"
  #   puts "*" * @dealer.card.length
  #   puts "Денег осталось: #{@dealer.bank}"
  #   puts "Дилера очки: #{@dealer.points}"
  # end

end