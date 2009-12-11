require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_should_create_with_teams
    white_player_ids = [players(:ede).id]
    yellow_player_ids = [players(:marzel).id, ]

    game = Game.create_with_teams(white_player_ids, yellow_player_ids)
    
    assert white_team = game.white_team
    assert_equal 1, white_team.players.count
    assert_equal players(:ede), white_team.players.first
    
    assert yellow_team = game.yellow_team
    assert_equal players(:marzel), yellow_team.players.first
  end
  
end
