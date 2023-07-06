# frozen_string_literal: true

class CardDeck
  attr_reader :new_cards

  CARDS_WITH_NUMBERS = (2..10).to_a
  CARDS_WITH_PICTURE = %w[J Q K].freeze
  CARD_SUITS = ['♥', '♠', '♣', '♦'].freeze

  def initialize
    # Неиспользованные карты
    @new_cards = []
    deck_building_num
    deck_building_pic
    deck_building_a
    @new_cards.shuffle! # Перемешать
  end

  private

  # Cоздание колоды
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

  def deck_building_a
    CARD_SUITS.each do |suits|
      @new_cards << Cards.new('A', 11, suits)
    end
  end
end
