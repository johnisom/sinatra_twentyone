# frozen_string_literal: true

# Card class with rank and suit
class Card
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    @rank.to_s + @suit
  end

  def to_a
    [@rank, @suit]
  end

  def value
    case @rank
    when 'A'           then 11
    when 'K', 'Q', 'J' then 10
    else               @rank
    end
  end

  def ace?
    @rank == 'A'
  end
end
