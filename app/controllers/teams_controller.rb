class TeamsController < ApplicationController
  def index
    @teams = Team.all_teams

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

end
