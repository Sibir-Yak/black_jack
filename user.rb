class User
  attr_accessor :bank, :card, :points

  def initialize(name)
    @bank = 100
    @name = name
    @card = []
    @points = 0
  end

end