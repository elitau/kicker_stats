class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  helper_method :current_player
  
  private
  
  def current_player_session
    return @current_player_session if defined?(@current_player_session)
    @current_player_session = PlayerSession.find
  end
  
  def current_player
    return @current_player if defined?(@current_player)
    @current_player = current_player_session && current_player_session.record
  end

end
