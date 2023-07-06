# frozen_string_literal: true

class BlackJack
  attr_reader :user, :dealer, :card_deck, :bank

  DEFAULT_BET = 10

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new
    @viev = Visualization.new
    @bank = 0
    #  Пройденый этап чтобы не повторялось
    @passed_stage = []
  end

  def start
    @card_deck = CardDeck.new
    bet
    2.times { distribution(@user) }
    2.times { distribution(@dealer) }
    loop do
      @viev.visualization_step(@user, false)
      @viev.visualization_step(@dealer, true)
      @viev.introduction(@passed_stage) # пройденый этап передаем
      user_choice = gets.chomp.to_i
      @passed_stage << user_choice
      case user_choice
      when 1
        distribution(@user)
        @viev.visualization_step(@user, false)
      when 2
        distribution(@dealer) if @dealer.points <= 17
        @viev.visualization_step(@dealer, false)
      when 3
        distribution(@dealer) if @dealer.card.size == 2 && @dealer.points <= 17
        @viev.visualization_step(@user, false)
        @viev.visualization_step(@dealer, false)
        win
        return
      end
      break if user_choice.zero?
    end
    puts 'Спасибо до свиданья, надеюсь вы всё просрали'
  end

  private

  # Раздача чел.
  def distribution(player)
    card = @card_deck.new_cards.shift # извлечь из масива с удалением
    player.card.push(card)
  end

  # Вскрываем карты, финиш.
  def win
    distribute_bank
    @viev.visualization_win(self, who_wins)
    another_game
  end

  # Кто победил логика с присвоением
  def who_wins
    if @user.points > @dealer.points && @user.points <= 21
      :user
    elsif @user.points <= 21 && @dealer.points > 21
      :user
    elsif @user.points == @dealer.points && @user.points <= 21
      :draw
    elsif @user.points == @dealer.points && @user.points > 21
      :draw
    elsif @user.points > 21 && @dealer.points > 21
      :draw
    else
      :dealer
    end
  end

  # Банковская операция
  def distribute_bank
    case who_wins
    when :user
      @user.bank += 2 * DEFAULT_BET
      @bank -= 2 * DEFAULT_BET
    when :draw
      @user.bank += DEFAULT_BET
      @dealer.bank += DEFAULT_BET
      @bank -= 2 * DEFAULT_BET
    when :dealer
      @dealer.bank += 2 * DEFAULT_BET
      @bank -= 2 * DEFAULT_BET
    end
  end

  # Следующая игра проверка
  def another_game
    if @user.bank <= 0
      @viev.bank_zero(1)
      abort
    elsif @dealer.bank <= 0
      @viev.bank_zero(2)
      abort
    else
      @viev.another_game
    end
    @passed_stage.clear
    @dealer.card.clear && @user.card.clear
    start
  end

  # Ставка
  def bet
    @user.bank -= DEFAULT_BET
    @dealer.bank -= DEFAULT_BET
    @bank += 2 * DEFAULT_BET
  end
end
