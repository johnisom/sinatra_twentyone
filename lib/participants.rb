# frozen_string_literal: true

# Base participant class
class Participant
  attr_reader :hand

  def initialize
    @hand = []
  end

  def busted?(max_limit)
    total(max_limit) > max_limit
  end

  def total(max_limit)
    Deck.total(@hand, max_limit)
  end

  def clear_hand
    @hand.clear
  end
end

# Dealer class with one extra behavior than participant
class Dealer < Participant
  def satisfied?(min, max_limit)
    total(max_limit) >= min
  end
end

# Player class equivalent to participant
class Player < Participant
end
