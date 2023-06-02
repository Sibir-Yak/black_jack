class Cards
  attr_reader :card_name, :card_points, :card_suits
  def initialize(name, points, suits)
    @card_name = name
    @card_points = points
    @card_suits = suits
  end
end