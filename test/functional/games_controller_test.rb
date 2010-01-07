require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game_attributes(:best_of => 1)
    end

    assert_redirected_to games_path
  end
  
  test "should render next match form if playing best_of 3" do
    assert_difference('Game.count') do
      post :create, game_attributes
    end
    game = assigns(:game)
    assert_redirected_to new_game_match_path(game)
  end

  test "should show game" do
    get :show, :id => games(:four_players_game).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => games(:four_players_game).to_param
    assert_response :success
  end

  test "should update game" do
    put :update, :id => games(:two_players_game).to_param, :game => { }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, :id => games(:two_players_game).to_param
    end

    assert_redirected_to games_path
  end
  
  def game_attributes(attributes = {})
    {
      :white_goals       => 4,
      :yellow_goals      => 6,
      :white_player_ids  => games(:four_players_game).matches.first.yellow_player_ids,
      :yellow_player_ids => games(:four_players_game).matches.first.white_player_ids,
      :best_of           => 3
    }.merge(attributes)
  end
end
