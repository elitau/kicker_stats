require 'test_helper'

class PlayerSessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PlayerSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PlayerSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    player_session = PlayerSession.first
    delete :destroy, :id => player_session
    assert_redirected_to root_url
    assert !PlayerSession.exists?(player_session.id)
  end
end
