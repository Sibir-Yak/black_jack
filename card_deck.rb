class Card_Deck

  attr_reader :new_cards, :used_cards

  CARDS_WITH_NUMBERS = (2..10).to_a
  CARDS_WITH_PICTURE = [ 'J', 'Q', 'K', 'A']
  CARD_SUITS = ['♥', '♠', '♣', '♦']

  def initialize
    # @cards_with_numbers = (2..10).to_a
    # @cards_with_picture = [ 'J', 'Q', 'K', 'A']
    # @card_suits = ['♥', '♠', '♣', '♦']
    #Неиспользованные карты
    @new_cards = []
    #Использованные карты
    @used_cards = []
  end

  def deck_building
    deck_building_num
    deck_building_pic
  end

  #Cоздание колоды
  def deck_building_num
    CARDS_WITH_NUMBERS.each do |card|
      CARD_SUITS.each do |suits|
        @new_cards << Cards.new(card, card, suits)
      end
    end
  end

  def deck_building_pic
    CARDS_WITH_PICTURE.each do |card|
      CARD_SUITS.each do |suits|
        @new_cards << Cards.new(card, 10, suits)
      end
    end
  end

  #Удаляем сигранную карту delete(train)
  def card_delete(card)
    @new_cards.delete(card)
  end
end
