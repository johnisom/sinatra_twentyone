# frozen_string_literal: true

require_relative 'participants'
require_relative 'deck'

# Game class that holds much of the static (noninteractive)
# logic
class Game
  MAX_LIMIT = 21
  DEALER_MIN = MAX_LIMIT - 4

  include Displayable

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset_game
    @deck = Deck.new
    @player.clear_hand
    @dealer.clear_hand
  end

  def play_game
    loop do
      deal_initial_cards
      player_turn
      dealer_turn unless player_bust?
      reset_game
    end
  end

  def hit(participant)
    @deck.deal(participant.hand)
  end

  def deal_initial_cards
    2.times do
      hit(@player)
      hit(@dealer)
    end
  end

  def dealer_turn
    hit(@dealer) until @dealer.satisfied?(DEALER_MIN, MAX_LIMIT)
    show_dealer_hand
  end

  def player_bust?
    @player.busted?(MAX_LIMIT)
  end

  def dealer_bust?
    @dealer.busted?(MAX_LIMIT)
  end

  def result
    return [:dealer, true] if player_bust?
    return [:player, true] if dealer_bust?
    case @player.total(MAX_LIMIT) <=> @dealer.total(MAX_LIMIT)
    when 1 then [:player, false]
    when 0 then [:neither, false]
    when -1 then [:dealer, false]
    end
  end
end
