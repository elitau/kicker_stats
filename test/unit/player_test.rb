require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def test_wins
    player = players(:tim)
    assert_equal 2, player.wins(-1)
    assert_equal 1, player.wins(1)
    assert_equal 1, player.wins(2)
  end

  def test_full_name
    assert_equal 'John Doe', full_name('John', 'Doe'), "first and last name given"
    assert_equal 'John', full_name('John', nil), "first name given"
    assert_equal 'Doe', full_name(nil, 'Doe'), "last name given"
    assert_equal '', full_name(nil, nil), "no last name and no first name given"
  end

  def full_name(first, last)
    Player.new(:firstname => first, :lastname => last).full_name
  end
end
