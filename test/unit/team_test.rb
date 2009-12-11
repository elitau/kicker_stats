require 'test_helper'

class TeamTest < ActiveSupport::TestCase
# TODO müsste man mal noch dry machen

  # Für diese Daten gibt es noch kein Team, 
  # beide Player haben aber ein anderes Team 
  def test_should_find_team_by_two_player_ids
    player_ids = [players(:fab).id, players(:tim).id]
    assert_nil Team.find_team_for_player_ids(player_ids)
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:fab))
    assert team.players.include?(players(:tim))
    assert_equal 2, team.players.size
  end

  # Für diese Daten gibt es bereits ein Team, 
  # beide Player haben außerdem ein weiteres Team 
  def test_should_create_team_by_two_player_ids
    player_ids = [players(:ede).id, players(:tim).id]
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:ede))
    assert team.players.include?(players(:tim))
    assert_equal 2, team.players.size
  end
  
  # Für diese Daten gibt es noch kein Team, 
  # Der Player hat aber ein anderes Team 
  def test_should_create_team_by_one_player_id
    player_ids = [players(:fab).id]
    assert_nil Team.find_team_for_player_ids(player_ids)
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:fab))
    assert_equal 1, team.players.size
  end
  
  # Für diese Daten gibt es bereits ein Team, 
  # Der Player hat außerdem ein weiteres Team 
  def test_should_find_team_by_one_player_id
    player_ids = [players(:ede).id]
    assert team = Team.find_or_create_team_for_player_ids(player_ids)
    assert_kind_of Team, team
    assert team.players.include?(players(:ede))
    assert_equal 1, team.players.size
  end
  
  # Für diese Daten gibt es noch gar kein Team,  
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
