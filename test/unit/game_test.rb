require 'test_helper'

class GameTest < ActiveSupport::TestCase
  
  def test_should_return_winner_for_single_team_best_of_1
    test_game = games(:two_players_game)
    assert test_game.winner?(players(:tim))
    assert !test_game.winner?(players(:ede))
  end
  
  def test_should_return_winner_for_double_team_best_of_3
    test_game = games(:four_players_game)
    assert test_game.winner?(players(:tim))
    assert test_game.winner?(players(:ede))
    assert !test_game.winner?(players(:fab))
  end
  
  def test_winner_players
    test_game = games(:four_players_game)
    assert_equal [players(:ede), players(:tim)], test_game.winner_players
  end

  def test_should_create_games
    best_of = 3
    assert game = Game.create_game_with_matches_and_teams(
      :best_of => best_of,
      :white_goals      => 3,
      :yellow_goals     => 6,
      :white_player_ids    => [players(:ede).id],
      :yellow_player_ids   => [players(:tim).id]
    )
    assert_kind_of Game, game
    assert !game.matches.empty?
    match = game.matches.first
    match.reload
    assert match.white_players.include?(players(:ede))
    assert match.yellow_players.include?(players(:tim))
  end
  
end
