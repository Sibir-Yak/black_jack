# frozen_string_literal: true

class Player
  attr_accessor :bank, :card, :name

  def initialize(_name = '')
    @name = nil
    @bank = 100
    @card = []
  end

  def points
    points = 0
    @card.each do |score|
      points += if score.card_name == 'A' && points <= 10
                  score.card_points
                elsif score.card_name == 'A' && points > 10
                  1
                else
                  score.card_points
                end
    end
    correction_points(points)
  end

  # Убираем 10 очков если есть тузец, а очей многовато.
  def correction_points(points)
    @card.each do |score|
      points -= 10 if score.card_name == 'A' && points > 21
    end
    points
  end
end
