class TeamsController < ApplicationController
  def index
    @teams = Team.all(:select => "DISTINCT(team_number)", :order => "team_number")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

end
