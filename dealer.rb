class Dealer
  attr_accessor :bank, :card, :points

  def initialize
    @bank = 100
    @card = []
    @points = 0
  end
end
