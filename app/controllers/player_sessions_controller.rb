class PlayerSessionsController < ApplicationController
  def new
    @player_session = PlayerSession.new
  end
  
  def create
    @player_session = PlayerSession.new(params[:player_session])
    if @player_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @player_session = PlayerSession.find
    @player_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
