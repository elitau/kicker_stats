require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  
  def test_should_have_goals_shot_by_player
    # ede und tim sind im weissen team und haben 6 tore geschossen und 2 kassiert
    match = matches(:four_players_game_first_match)
    player = players(:ede)
    assert_equal 6, match.goals_shot_by_player(player)
  end  
  
  def test_should_have_goals_shot_by_player
    # ede und tim sind im weissen team und haben 6 tore geschossen und 2 kassiert
    match = matches(:four_players_game_first_match)
    player = players(:ede)
    assert_equal 2, match.goals_sucked_by_player(player)
  end
  

end
