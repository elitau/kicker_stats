require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_should_return_winner_for_single_team_best_of_1
    test_game = games(:two_players_game)
    assert names = test_game.winner()
    assert_kind_of String, names
    assert_equal "Tim", names
  end
  
  def test_should_return_winner_for_double_team_best_of_3
    test_game = games(:four_players_game)
    assert names = test_game.winner()
    assert_kind_of String, names
    assert_equal "Ede und Tim", names
  end

  def test_should_create_games
    best_of = 3
    assert game = Game.create_game(best_of)
    assert_kind_of Game, game
  end
end
