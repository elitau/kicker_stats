require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, :game_id => games(:four_players_game).id 
    assert_response :success
    assert_not_nil assigns(:matches)
  end

  test "should get new" do
    get :new, :game_id => games(:game_with_one_match_of_three).id
    assert_response :success
  end

  test "should create match" do
    game = games(:game_with_one_match_of_three)
    first_match = game.matches.first
    params = match_params(
      :white_player_ids => first_match.yellow_player_ids,
      :yellow_player_ids => first_match.white_player_ids,
      :game_id => game.id
    )
    assert_difference('Match.count') do
      post :create, params
    end

    assert_redirected_to new_game_match_path(assigns(:game))
  end

  test "should show match" do
    get :show, :id => matches(:four_players_game_first_match).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, 
      :id => matches(:four_players_game_first_match).to_param, 
      :game_id => games(:four_players_game).id
    assert_response :success
  end

  test "should update match" do
    put :update, :id => matches(:four_players_game_first_match).to_param, :match => match_params
    assert_redirected_to match_path(assigns(:match))
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete :destroy, :id => matches(:four_players_game_second_match).to_param
    end

    assert_redirected_to matches_path
  end
  
  def match_params(attributes = {})
    options = {
      :white_goals   => 4,
      :yellow_goals  => 6
    }.merge(attributes)
  end
end
