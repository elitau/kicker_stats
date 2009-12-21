require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  # Für diese Daten gibt es noch kein Team, 
  # beide Player haben aber ein anderes Team 
  def test_should_find_team_by_two_player_ids
    player_ids = [players(:fab).id, players(:tim).id]
    assert_nil Team.find_team_number_for_player_ids(player_ids)
  end

  # Für diese Daten gibt es bereits ein Team, 
  # beide Player haben außerdem ein weiteres Team 
  def test_should_create_team_by_two_player_ids
    player_ids = [players(:ede).id, players(:tim).id]
    assert_equal 1, Team.find_team_number_for_player_ids(player_ids)
  end
  
  # Für diese Daten gibt es noch kein Team, 
  # Der Player hat aber ein anderes Team 
  def test_should_create_team_by_one_player_id
    player_ids = [players(:fab).id]
    assert_nil Team.find_team_number_for_player_ids(player_ids)
  end
  
  # Für diese Daten gibt es bereits ein Team, 
  # Der Player hat außerdem ein weiteres Team 
  def test_should_find_team_by_one_player_id
    player_ids = [players(:ede).id]
    assert_equal 3, Team.find_team_number_for_player_ids(player_ids)
  end
  
  # Für diese Daten gibt es noch gar kein Team,  
  def test_should_find_or_create_team_for_new_player
    player_ids = [players(:player_without_team).id]
    assert players(:player_without_team).teams.empty?
    assert_nil Team.find_team_number_for_player_ids(player_ids)
  end
  
  def test_should_be_a_single_team
    team_number = 3
    assert_equal true, Team.single?(team_number)
  end

  def test_should_be_a_double_team
    team_number = 1
    assert_equal false, Team.single?(team_number)
  end
end
