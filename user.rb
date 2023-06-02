class User
  attr_accessor :bank, :card, :points
  attr_reader :name

  def initialize(name)
    @bank = 100
    @name = name
    @card = []
    @points = 0
  end

end