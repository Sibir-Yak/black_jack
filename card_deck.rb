class Card_Deck

  attr_reader :new_cards, :used_cards

  def initialize
    @cards_with_numbers = (2..10).to_a
    @cards_with_picture = [ 'V', 'D', 'K', 'T']
    @card_suits = ['♥', '♠', '♣', '♦']
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
    @cards_with_numbers.each do |card|
      @card_suits.each do |suits|
        @new_cards << Cards.new(card, card, suits)
      end
    end
  end

  def deck_building_pic
    @cards_with_picture.each do |card|
      @card_suits.each do |suits|
        @new_cards << Cards.new(card, 10, suits)
      end
    end
  end

  #Удаляем сигранную карту delete(train)
  def card_delete(card)
    @new_cards.delete(card)
  end
end
