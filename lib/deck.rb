# frozen_string_literal: true

require_relative 'card'

# Deck class that takes care of creating, dealing, and counting cards
class Deck
  SUITS = %w(H D S C).freeze
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize
    @cards = RANKS.product(SUITS).map { |el| Card.new(*el) }.shuffle
  end

  def deal(hand)
    hand << draw
  end

  def draw
    @cards.pop
  end

  def self.total(hand, max_limit)
    total = hand.sum(&:value)
    ace_count = hand.count(&:ace?)
    ace_count.times do
      total -= 10 if total > max_limit
    end
    total
  end
end
