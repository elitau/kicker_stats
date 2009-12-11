require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  def test_should_find_or_create_by_two_player_ids
    player_ids = [players(:ede).id, players(:tim).id]
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:ede))
    assert team.players.include?(players(:tim))
  end
  
  def test_should_not_find_team
    # Marzel hat nur ein team mit fab
    player_ids = [players(:marzel).id]
    assert_nil Team.find_team_for_player_ids(player_ids)
  end
  
  def test_should_find_or_create_by_one_player_id
    player_ids = [players(:ede).id]
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:ede))
    assert_equal 1, team.players.size
  end
  
  def test_should_find_or_create_team_for_new_player
    player_ids = [players(:player_without_team).id]
    assert players(:player_without_team).teams.empty?
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:player_without_team))
    assert_equal 1, team.players.size
    # Mit dem parameter true beim zugriff über eine assoziation werden die
    # objekte neu aus der db geladen
    assert_equal team, players(:player_without_team).teams(true).first
  end
end
