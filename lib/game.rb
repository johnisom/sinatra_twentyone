# frozen_string_literal: true

require_relative 'participants'
require_relative 'deck'

# Game class that holds much of the static (noninteractive)
# logic
class Game
  MAX_LIMIT = 21
  DEALER_MIN = MAX_LIMIT - 4

  attr_reader :player, :dealer
  attr_accessor :game_over
  
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    reset_game
  end

  def reset_game
    @deck = Deck.new
    @game_over = false
    @player.clear_hand
    @dealer.clear_hand
    deal_initial_cards
  end

  def total_reset
    @player.clear_score
    @dealer.clear_score
    reset_game
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
  end

  def player_bust?
    @player.busted?(MAX_LIMIT)
  end

  def dealer_bust?
    @dealer.busted?(MAX_LIMIT)
  end

  def winner
    case @player.total(MAX_LIMIT) <=> @dealer.total(MAX_LIMIT)
    when 1 then :player
    when 0 then :neither
    when -1 then :dealer
    end
  end
end
