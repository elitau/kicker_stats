require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def test_wins
    player = players(:tim)
    white_winning_matches = player.matches.find(:all, :conditions => ["teams.team_color = 'white' AND matches.white_goals > matches.yellow_goals"])
    yellow_winning_matches = player.matches.find(:all, :conditions => ["teams.team_color = 'yellow' AND matches.white_goals < matches.yellow_goals"])
    
    assert_equal 1, white_winning_matches.size
    assert_equal 2, yellow_winning_matches.size
    all_winning_matches = white_winning_matches+yellow_winning_matches
    assert_equal 3, player.all_winning_matches.size
    assert_equal all_winning_matches.sort_by(&:id), player.all_winning_matches.sort_by(&:id)
    assert_equal 2, player.double_winning_matches.size
    assert_equal 1, player.single_winning_matches.size
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

  def test_should_have_goals_shot
    player = Player.new
    match = Match.new
    match.expects(:goals_shot_by_player).at_least_once.with(player).returns(4)
    player.expects(:matches).returns([match, match])
    assert_equal 8, player.goals_shot
  end
  
  def test_should_have_sucked_goals
    player = Player.new
    match = Match.new
    match.expects(:goals_sucked_by_player).at_least_once.with(player).returns(4)
    player.expects(:matches).returns([match, match])
    assert_equal 8, player.sucked_goals
  end
  
end
